module StoryTime.Update exposing (init, update)

import StoryTime.Ports exposing (sendStoryToRead)
import StoryTime.TemplateSelection exposing (TemplateSelection(..), selectTemplateByNameString)
import StoryTime.Story
    exposing
        ( StoryPage
        , characterFromStory
        , defaultStory
        , objectFromStory
        , pageToString
        )
import StoryTime.StoryBuildProgress
    exposing
        ( StoryBuildProgress(..)
        , selectName
        , selectTemplate
        , selectObject
        , defaultStoryBuildProgress
        )
import StoryTime.Types exposing (Model, Msg(..), setName, setObject)
import StoryTime.NameSelection exposing (NameSelection(..))
import StoryTime.ObjectSelection exposing (ObjectSelection(..))


init : ( Model, Cmd Msg )
init =
    ( { storyBuildProgress = defaultStoryBuildProgress
      , name = NoNameSelected
      , template = NoTemplateSelected
      , object = NoObjectSelected
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ storyBuildProgress, template, name, object } as model) =
    let
        noop =
            ( model, Cmd.none )
    in
        case msg of
            PageReadRequested storyPage ->
                ( model, readStoryPage storyBuildProgress storyPage )

            SetName nameString ->
                ( setName nameString model, Cmd.none )

            SelectName ->
                ( { model | storyBuildProgress = selectName name storyBuildProgress }, Cmd.none )

            SetTemplate templateNameString ->
                ( { model | template = (selectTemplateByNameString templateNameString) }, Cmd.none )

            SelectTemplate ->
                ( { model | storyBuildProgress = selectTemplate template storyBuildProgress }, Cmd.none )

            SetObject objectString ->
                ( setObject objectString model, Cmd.none )

            SelectObject ->
                ( { model | storyBuildProgress = selectObject object storyBuildProgress }, Cmd.none )

            _ ->
                noop


readStoryPage : StoryBuildProgress -> StoryPage -> Cmd Msg
readStoryPage storyBuildProgress storyPage =
    case storyBuildProgress of
        Complete story _ ->
            sendStoryToRead <| pageToString story storyPage

        _ ->
            Cmd.none
