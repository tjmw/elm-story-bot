module StoryTime.NameSelection exposing (NameSelection(..), nameSelectionToString, stringToNameSelection)


type NameSelection
    = NameSelection String
    | NoName


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
            NoName

        _ ->
            NameSelection string
