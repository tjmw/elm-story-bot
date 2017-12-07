module StoryTime.StoryBuildProgress exposing (StoryBuildProgress(..), selectName)

import StoryTime.Story exposing (Story, StoryTemplate, Character(..))
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
