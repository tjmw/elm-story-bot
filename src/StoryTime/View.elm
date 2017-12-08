module StoryTime.View exposing (view)

import Html exposing (Html, text, div, section, h1, img, button, input, label, select, option)
import Html.Attributes exposing (class, id, for)
import Html.Events exposing (onClick, onInput, on)
import Json.Decode
import List
import StoryTime.NameSelection exposing (NameSelection(..), nameSelectionToString)
import StoryTime.Story
    exposing
        ( Story
        , StoryPage
        , characterFromStory
        , objectFromStory
        , pageToString
        , storyToPages
        , templateNames
        )
import StoryTime.StoryBuildProgress exposing (StoryBuildProgress(..))
import StoryTime.Types exposing (Model, Msg(..))


view : Model -> Html Msg
view { storyBuildProgress, name } =
    case storyBuildProgress of
        Incomplete ->
            renderNameSelection name

        CharacterSelected character ->
            renderTemplateSelection

        Complete story ->
            renderStory story

        _ ->
            div [] [ text "Implement me" ]


renderNameSelection : NameSelection -> Html Msg
renderNameSelection name =
    section [ class "container" ]
        [ label [ for "label-field" ] [ text "Enter your name" ]
        , input [ id "label-field", onInput SetName ] [ text <| nameSelectionToString name ]
        , button [ onClick SelectName ] [ text "Select name" ]
        ]


renderTemplateSelection : Html Msg
renderTemplateSelection =
    section [ class "container" ]
        [ select [ onChange SetTemplate ] <| emptyOption :: templateOptions
        , button [ onClick SelectTemplate ] [ text "Select story template" ]
        ]


emptyOption : Html Msg
emptyOption =
    option [] []


templateOptions : List (Html Msg)
templateOptions =
    List.map templateOption templateNames


templateOption : String -> Html Msg
templateOption name =
    option [ id name ] [ text name ]


renderStory : Story -> Html Msg
renderStory story =
    section [ class "container" ]
        (List.map
            (renderPage story)
         <|
            storyToPages story
        )


renderPage : Story -> StoryPage -> Html Msg
renderPage story page =
    div [ class "line center", onClick <| PageReadRequested page ]
        [ text <| pageToString story page
        ]


onChange : (String -> msg) -> Html.Attribute msg
onChange tagger =
    on "change" (Json.Decode.map tagger Html.Events.targetValue)
