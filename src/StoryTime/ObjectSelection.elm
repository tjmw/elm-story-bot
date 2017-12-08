module StoryTime.ObjectSelection exposing (ObjectSelection(..), objectSelectionToString, stringToObjectSelection)


type ObjectSelection
    = ObjectSelection String
    | NoObjectSelected


objectSelectionToString : ObjectSelection -> String
objectSelectionToString objectSelection =
    case objectSelection of
        ObjectSelection string ->
            string

        _ ->
            ""


stringToObjectSelection : String -> ObjectSelection
stringToObjectSelection string =
    case string of
        "" ->
            NoObjectSelected

        _ ->
            ObjectSelection string
