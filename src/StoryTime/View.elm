module StoryTime.View exposing (view)

import Html exposing (Html, text, div, section, h1, img, button, input, label, select, option, span, i)
import Html.Attributes exposing (class, id, for, placeholder, name, disabled, selected, value)
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
            , text "in the story..."
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
        [ h1 [ class "headline", ariaLabel "Step 2" ] [ text "2" ]
        , label [ class "center line", for "label-field" ] [ text "The story I want to add them to is..." ]
        , div [ class "select-wrapper" ]
            [ select
                [ class "select f-secondary f-700 mb-primary"
                , onChange SetTemplate
                , name "Pick a Story"
                ]
              <|
                placeholderOption
                    :: templateOptions
            , i [ class "caret" ] []
            ]
        , button [ class "f-secondary f-500 button button-primary", onClick SelectTemplate ] [ text "Next" ]
        ]


renderObjectSelection : ObjectSelection -> Html Msg
renderObjectSelection object =
    section [ class "container" ]
        [ h1 [ class "headline", ariaLabel "Step 3" ] [ text "3" ]
        , label [ class "center line", for "label-field" ]
            [ text "Write the name of the "
            , span [ class "highlight" ] [ text "object " ]
            , text "to put in the story..."
            ]
        , input
            [ class "textInput f-secondary f-700 mb-primary"
            , id "label-field"
            , placeholder "Teddy Bear"
            , onInput SetObject
            ]
            [ text <| objectSelectionToString object ]
        , button [ class "f-secondary f-500 button button-primary", onClick SelectObject ] [ text "Next" ]
        ]


placeholderOption : Html Msg
placeholderOption =
    option [ value "", disabled True, selected True ] [ text "Select your option" ]


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
