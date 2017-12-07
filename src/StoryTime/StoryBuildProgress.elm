module StoryTime.StoryBuildProgress exposing (StoryBuildProgress(..), selectName, selectTemplate)

import StoryTime.Story exposing (Story, StoryTemplate, Character(..))
import StoryTime.TemplateSelection exposing (TemplateSelection(..))
import StoryTime.Name exposing (Name(..))


type StoryBuildProgress
    = Incomplete
    | CharacterSelected Character
    | TemplateSelected Character StoryTemplate
    | Complete Story


selectName : Name -> StoryBuildProgress -> StoryBuildProgress
selectName name progress =
    case name of
        Name nameString ->
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
