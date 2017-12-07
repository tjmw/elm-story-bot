module StoryTime.View exposing (view)

import Html exposing (Html, text, div, h1, img, button)
import Html.Events exposing (onClick)
import List
import StoryTime.Types
    exposing
        ( Model
        , Msg(..)
        , Story
        , StoryPage
        , characterFromStory
        , objectFromStory
        , pageToString
        , storyToPages
        )


view : Model -> Html Msg
view { story } =
    div []
        (List.map
            (renderPage story)
         <|
            storyToPages story
        )


renderPage : Story -> StoryPage -> Html Msg
renderPage story page =
    let
        character =
            characterFromStory story

        object =
            objectFromStory story
    in
        div [ onClick <| PageReadRequested page ]
            [ text <| pageToString character object page
            ]
