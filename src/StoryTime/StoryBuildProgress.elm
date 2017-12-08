module StoryTime.StoryBuildProgress
    exposing
        ( StoryBuildProgress(..)
        , ReadingProgress(..)
        , getCurrentPage
        , selectName
        , selectTemplate
        , selectObject
        , defaultStoryBuildProgress
        , resetReadingProgress
        , turnPage
        )

import StoryTime.Story
    exposing
        ( Story(..)
        , StoryTemplate
        , StoryPage
        , Character(..)
        , Object(..)
        , defaultStory
        , getFirstPage
        , getNextPage
        )
import StoryTime.TemplateSelection exposing (TemplateSelection(..))
import StoryTime.NameSelection exposing (NameSelection(..))
import StoryTime.ObjectSelection exposing (ObjectSelection(..))


type ReadingProgress
    = NotStarted
    | InProgress StoryPage
    | Finished


type StoryBuildProgress
    = Incomplete
    | CharacterSelected Character
    | TemplateSelected Character StoryTemplate
    | Complete Story ReadingProgress


defaultStoryBuildProgress : StoryBuildProgress
defaultStoryBuildProgress =
    Complete defaultStory NotStarted


selectName : NameSelection -> StoryBuildProgress -> StoryBuildProgress
selectName name progress =
    case name of
        NameSelection nameString ->
            case progress of
                Incomplete ->
                    CharacterSelected (Character nameString)

                _ ->
                    progress

        _ ->
            progress


selectTemplate : TemplateSelection -> StoryBuildProgress -> StoryBuildProgress
selectTemplate templateSelection progress =
    case templateSelection of
        TemplateSelection template ->
            case progress of
                CharacterSelected character ->
                    TemplateSelected character template

                _ ->
                    progress

        _ ->
            progress


selectObject : ObjectSelection -> StoryBuildProgress -> StoryBuildProgress
selectObject objectSelection progress =
    case objectSelection of
        ObjectSelection name ->
            case progress of
                TemplateSelected character template ->
                    Complete (Story template character (Object name)) NotStarted

                _ ->
                    progress

        _ ->
            progress


turnPage : StoryBuildProgress -> StoryBuildProgress
turnPage build =
    case build of
        Complete story progress ->
            Complete story <| incrementPage progress story

        _ ->
            build


incrementPage : ReadingProgress -> Story -> ReadingProgress
incrementPage progress story =
    case progress of
        NotStarted ->
            getFirstPage story |> Maybe.map InProgress |> Maybe.withDefault Finished

        InProgress currentPage ->
            getNextPage story currentPage |> Maybe.map InProgress |> Maybe.withDefault Finished

        Finished ->
            Finished


getCurrentPage : StoryBuildProgress -> Maybe StoryPage
getCurrentPage build =
    case build of
        Complete _ readingProgress ->
            case readingProgress of
                InProgress page ->
                    Just page

                _ ->
                    Nothing

        _ ->
            Nothing


resetReadingProgress : StoryBuildProgress -> StoryBuildProgress
resetReadingProgress build =
    case build of
        Complete story _ ->
            Complete story NotStarted

        _ ->
            build
