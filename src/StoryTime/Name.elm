module StoryTime.Name exposing (Name(..), nameToString, stringToName)


type Name
    = Name String
    | NoName


nameToString : Name -> String
nameToString name =
    case name of
        Name string ->
            string

        _ ->
            ""


stringToName : String -> Name
stringToName string =
    case string of
        "" ->
            NoName

        _ ->
            Name string
