module StoryTime.View exposing (view)

import Html exposing (Html, text, div, section, h1, img, button, input, label)
import Html.Attributes exposing (class, id, for)
import Html.Events exposing (onClick, onInput)
import List
import StoryTime.Name exposing (Name(..), nameToString)
import StoryTime.Story
    exposing
        ( Story
        , StoryPage
        , characterFromStory
        , objectFromStory
        , pageToString
        , storyToPages
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


renderNameSelection : Name -> Html Msg
renderNameSelection name =
    section [ class "container" ]
        [ label [ for "label-field" ] [ text "Enter your name" ]
        , input [ id "label-field", onInput SetName ] [ text <| nameToString name ]
        , button [ onClick SelectName ] [ text "Select name" ]
        ]


renderTemplateSelection : Html Msg
renderTemplateSelection =
    section [ class "container" ]
        [ text "Choose a story template" ]


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
