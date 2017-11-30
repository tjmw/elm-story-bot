module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import List


---- TYPES ----


type Character
    = Boo
    | Scout
    | Dougie


type Object
    = Binoculars
    | ToolBox
    | Cake


type StoryComponent
    = Line String
    | CharacterPlaceholder
    | ObjectPlaceholder


type StoryTemplate
    = StoryTemplate (List StoryComponent)


type Story
    = Story StoryTemplate Character Object


someoneLosesSomething : StoryTemplate
someoneLosesSomething =
    StoryTemplate
        [ Line "Once upon a time, "
        , CharacterPlaceholder
        , Line "was on the way to the library, when they noticed they'd lost their"
        , ObjectPlaceholder
        , Line "This made"
        , CharacterPlaceholder
        , Line "really sad, because the"
        , ObjectPlaceholder
        , Line "was their favourite item."
        ]


readStory : Story -> String
readStory ((Story (StoryTemplate lines) character object) as story) =
    String.join " " <| List.map (readStoryComponent story) lines


readStoryComponent : Story -> StoryComponent -> String
readStoryComponent (Story _ character object) storyComponent =
    case storyComponent of
        Line line ->
            line

        CharacterPlaceholder ->
            characterToString character

        ObjectPlaceholder ->
            objectToString object


characterToString : Character -> String
characterToString character =
    case character of
        Boo ->
            "Boo"

        Scout ->
            "Scout"

        Dougie ->
            "Dougie"


objectToString : Object -> String
objectToString object =
    case object of
        Binoculars ->
            "binoculars"

        ToolBox ->
            "tool box"

        Cake ->
            "cake"


scoutLosesHerToolbox : Story
scoutLosesHerToolbox =
    Story someoneLosesSomething Scout ToolBox



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ text <| readStory scoutLosesHerToolbox
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
