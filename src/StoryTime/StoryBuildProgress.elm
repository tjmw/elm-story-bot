module StoryTime.StoryBuildProgress exposing (StoryBuildProgress(..), ReadingProgress(..), selectName, selectTemplate, selectObject)

import StoryTime.Story exposing (Story(..), StoryTemplate, StoryPage, Character(..), Object(..))
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
