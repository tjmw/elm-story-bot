module Main exposing (..)

import Html
import StoryTime.View as View
import StoryTime.Types exposing (Model, Msg)
import StoryTime.Update as Update


main : Program Never Model Msg
main =
    Html.program
        { view = View.view
        , init = Update.init
        , update = Update.update
        , subscriptions = always Sub.none
        }
