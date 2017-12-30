module StoryTime.Update exposing (init, update)

import StoryTime.Ports exposing (sendStoryToRead)
import StoryTime.TemplateSelection exposing (TemplateSelection(..), selectTemplateByNameString)
import StoryTime.Story
    exposing
        ( StoryPage
        , characterFromStory
        , defaultStory
        , objectFromStory
        )
import StoryTime.StoryBuildProgress
    exposing
        ( StoryBuildProgress(..)
        , defaultStoryBuildProgress
        , getCurrentPage
        , resetReadingProgress
        , selectName
        , selectObject
        , selectTemplate
        , turnPage
        )
import StoryTime.Types exposing (Model, Msg(..), setName, setObject)
import StoryTime.NameSelection exposing (NameSelection(..))
import StoryTime.ObjectSelection exposing (ObjectSelection(..))
import StoryTime.StoryProgress exposing (currentPageToString)


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
            PageReadRequested ->
                ( model, readCurrentStoryPage storyBuildProgress )

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

            TurnPage ->
                handlePageTurn model

            ReadAgain ->
                ( { model | storyBuildProgress = resetReadingProgress storyBuildProgress }, Cmd.none )

            _ ->
                noop


handlePageTurn : Model -> ( Model, Cmd Msg )
handlePageTurn ({ storyBuildProgress } as model) =
    let
        newBuildProgress =
            turnPage storyBuildProgress

        page =
            getCurrentPage newBuildProgress

        cmd =
            readCurrentStoryPage newBuildProgress
    in
        ( { model | storyBuildProgress = newBuildProgress }, cmd )


readCurrentStoryPage : StoryBuildProgress -> Cmd Msg
readCurrentStoryPage storyBuildProgress =
    case storyBuildProgress of
        Complete storyProgress ->
            currentPageToString storyProgress
                |> Maybe.map sendStoryToRead
                |> Maybe.withDefault Cmd.none

        _ ->
            Cmd.none
