module StoryTime.View exposing (view)

import Html exposing (Html, text, div, section, h1, img, button, input, label, select, option, span)
import Html.Attributes exposing (class, id, for, placeholder)
import Html.Events exposing (onClick, onInput, on)
import Html.Attributes.Aria exposing (ariaLabel)
import Json.Decode
import List
import StoryTime.NameSelection exposing (NameSelection(..), nameSelectionToString)
import StoryTime.ObjectSelection exposing (ObjectSelection(..), objectSelectionToString)
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
view { storyBuildProgress, name, object } =
    case storyBuildProgress of
        Incomplete ->
            renderNameSelection name

        CharacterSelected character ->
            renderTemplateSelection

        TemplateSelected character template ->
            renderObjectSelection object

        Complete story ->
            renderStory story


renderNameSelection : NameSelection -> Html Msg
renderNameSelection name =
    section [ class "container" ]
        [ h1 [ class "headline", ariaLabel "Step 1" ] [ text "1" ]
        , label [ class "center line", for "label-field" ]
            [ text "Write the name of the "
            , span [ class "highlight" ] [ text "person " ]
            , text "in the story."
            ]
        , input
            [ class "textInput f-secondary f-700 mb-primary"
            , id "label-field"
            , placeholder "Wonder Woman"
            , onInput SetName
            ]
            [ text <| nameSelectionToString name ]
        , button [ class "f-secondary f-500 button button-primary", onClick SelectName ] [ text "Next" ]
        ]


renderTemplateSelection : Html Msg
renderTemplateSelection =
    section [ class "container" ]
        [ select [ onChange SetTemplate ] <| emptyOption :: templateOptions
        , button [ onClick SelectTemplate ] [ text "Select story template" ]
        ]


renderObjectSelection : ObjectSelection -> Html Msg
renderObjectSelection object =
    section [ class "container" ]
        [ label [ for "label-field" ] [ text "Enter an object name" ]
        , input [ id "label-field", onInput SetObject ] [ text <| objectSelectionToString object ]
        , button [ onClick SelectObject ] [ text "Select Object" ]
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
