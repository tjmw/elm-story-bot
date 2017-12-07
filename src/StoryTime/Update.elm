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
        )
import StoryTime.Types exposing (Model, Msg(..), setName)
import StoryTime.Name exposing (Name(..))


init : ( Model, Cmd Msg )
init =
    ( { storyBuildProgress = Incomplete
      , name = NoName
      , selectedTemplate = NoTemplateSelected
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ storyBuildProgress, selectedTemplate, name } as model) =
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
                ( { model | selectedTemplate = (selectTemplateByNameString templateNameString) }, Cmd.none )

            SelectTemplate ->
                ( { model | storyBuildProgress = selectTemplate selectedTemplate storyBuildProgress }, Cmd.none )

            _ ->
                noop


readStoryPage : StoryBuildProgress -> StoryPage -> Cmd Msg
readStoryPage storyBuildProgress storyPage =
    case storyBuildProgress of
        Complete story ->
            sendStoryToRead <| pageToString story storyPage

        _ ->
            Cmd.none
