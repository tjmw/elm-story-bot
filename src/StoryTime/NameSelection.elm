module StoryTime.NameSelection exposing (NameSelection(..), nameSelectionToString, stringToNameSelection)


type NameSelection
    = NameSelection String
    | NoNameSelected


nameSelectionToString : NameSelection -> String
nameSelectionToString nameSelection =
    case nameSelection of
        NameSelection string ->
            string

        _ ->
            ""


stringToNameSelection : String -> NameSelection
stringToNameSelection string =
    case string of
        "" ->
            NoNameSelected

        _ ->
            NameSelection string
