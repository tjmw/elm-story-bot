module StoryTime.Update exposing (init, update)

import StoryTime.Ports exposing (sendStoryToRead)
import StoryTime.Story
    exposing
        ( characterFromStory
        , defaultStory
        , objectFromStory
        , pageToString
        )
import StoryTime.StoryBuildProgress exposing (StoryBuildProgress(..), selectName)
import StoryTime.Types exposing (Model, Msg(..), setName)
import StoryTime.Name exposing (Name(..))


init : ( Model, Cmd Msg )
init =
    ( { storyBuildProgress = Incomplete, name = NoName }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ storyBuildProgress, name } as model) =
    let
        noop =
            ( model, Cmd.none )
    in
        case msg of
            PageReadRequested storyPage ->
                case storyBuildProgress of
                    Complete story ->
                        ( model, sendStoryToRead <| pageToString story storyPage )

                    _ ->
                        noop

            SetName nameString ->
                ( setName nameString model, Cmd.none )

            SelectName ->
                ( { model | storyBuildProgress = selectName model.name model.storyBuildProgress }, Cmd.none )

            _ ->
                noop
