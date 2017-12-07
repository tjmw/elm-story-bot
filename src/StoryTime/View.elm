module StoryTime.View exposing (view)

import Html exposing (Html, text, div, section, h1, img, button)
import Html.Attributes exposing (class)
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
