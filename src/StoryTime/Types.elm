module StoryTime.Types exposing (Model, Msg(..))

import StoryTime.Story exposing (Story, StoryPage)


type Msg
    = PageReadRequested StoryPage
    | NoOp


type alias Model =
    { story : Story }
