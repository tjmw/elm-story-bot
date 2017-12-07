module StoryTime.Types exposing (Model, Msg(..), setName)

import StoryTime.Name exposing (Name, stringToName)
import StoryTime.Story exposing (Story, StoryPage)
import StoryTime.StoryBuildProgress exposing (StoryBuildProgress)


type Msg
    = PageReadRequested StoryPage
    | SetName String
    | SelectName
    | NoOp


setName : String -> Model -> Model
setName nameString model =
    { model | name = stringToName nameString }


type alias Model =
    { storyBuildProgress : StoryBuildProgress
    , name : Name
    }
