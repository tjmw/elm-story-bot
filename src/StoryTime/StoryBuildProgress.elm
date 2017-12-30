module StoryTime.StoryBuildProgress
    exposing
        ( StoryBuildProgress(..)
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
import StoryTime.StoryProgress as StoryProgress exposing (StoryProgress(..), startStory)


type StoryBuildProgress
    = Incomplete
    | CharacterSelected Character
    | TemplateSelected Character StoryTemplate
    | Complete StoryProgress


defaultStoryBuildProgress : StoryBuildProgress
defaultStoryBuildProgress =
    Incomplete


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
                    Story template character (Object name)
                        |> startStory
                        |> Complete

                _ ->
                    progress

        _ ->
            progress


turnPage : StoryBuildProgress -> StoryBuildProgress
turnPage build =
    case build of
        Complete storyProgress ->
            Complete <| StoryProgress.turnPage storyProgress

        _ ->
            build


getCurrentPage : StoryBuildProgress -> Maybe StoryPage
getCurrentPage build =
    case build of
        Complete storyProgress ->
            StoryProgress.getCurrentPage storyProgress

        _ ->
            Nothing


resetReadingProgress : StoryBuildProgress -> StoryBuildProgress
resetReadingProgress build =
    case build of
        Complete storyProgress ->
            Complete <| StoryProgress.resetReadingProgress storyProgress

        _ ->
            build
