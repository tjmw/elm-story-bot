module StoryTime.Types exposing (Model, Msg(..), setName, setObject)

import StoryTime.NameSelection exposing (NameSelection, stringToNameSelection)
import StoryTime.ObjectSelection exposing (ObjectSelection, stringToObjectSelection)
import StoryTime.TemplateSelection exposing (TemplateSelection(..))
import StoryTime.Story exposing (Story, StoryPage)
import StoryTime.StoryBuildProgress exposing (StoryBuildProgress)


type Msg
    = PageReadRequested StoryPage
    | SetName String
    | SelectName
    | SetTemplate String
    | SelectTemplate
    | SetObject String
    | SelectObject
    | NoOp


setName : String -> Model -> Model
setName nameString model =
    { model | name = stringToNameSelection nameString }


setObject : String -> Model -> Model
setObject objectString model =
    { model | object = stringToObjectSelection objectString }


type alias Model =
    { storyBuildProgress : StoryBuildProgress
    , template : TemplateSelection
    , name : NameSelection
    , object : ObjectSelection
    }
