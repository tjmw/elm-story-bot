module StoryTime.TemplateSelection exposing (TemplateSelection(..), selectTemplateByNameString)

import StoryTime.Story exposing (StoryTemplate, findTemplateByNameString)


type TemplateSelection
    = NoTemplateSelected
    | TemplateSelection StoryTemplate


selectTemplateByNameString : String -> TemplateSelection
selectTemplateByNameString name =
    case findTemplateByNameString name of
        Just template ->
            TemplateSelection template

        Nothing ->
            NoTemplateSelected
