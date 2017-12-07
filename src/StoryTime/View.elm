module StoryTime.View exposing (view)

import Html exposing (Html, text, div, h1, img, button)
import Html.Events exposing (onClick)
import List
import StoryTime.Story
    exposing
        ( Story
        , StoryPage
        , characterFromStory
        , objectFromStory
        , pageToString
        , storyToPages
        )
import StoryTime.Types exposing (Model, Msg(..))


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
    div [ onClick <| PageReadRequested page ]
        [ text <| pageToString story page
        ]
