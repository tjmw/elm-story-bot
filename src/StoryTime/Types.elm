module StoryTime.Types exposing (Model, Msg(..), setName)

import StoryTime.NameSelection exposing (NameSelection, stringToNameSelection)
import StoryTime.TemplateSelection exposing (TemplateSelection(..))
import StoryTime.Story exposing (Story, StoryPage)
import StoryTime.StoryBuildProgress exposing (StoryBuildProgress)


type Msg
    = PageReadRequested StoryPage
    | SetName String
    | SelectName
    | SetTemplate String
    | SelectTemplate
    | NoOp


setName : String -> Model -> Model
setName nameString model =
    { model | name = stringToNameSelection nameString }


type alias Model =
    { storyBuildProgress : StoryBuildProgress
    , template : TemplateSelection
    , name : NameSelection
    }
