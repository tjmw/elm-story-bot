port module Main exposing (..)

import Html exposing (Html, text, div, h1, img, button)
import Html.Events exposing (onClick)
import List


port sendStoryToRead : String -> Cmd msg



---- TYPES ----


type Character
    = Character String


type Object
    = Object String


type StoryComponent
    = Line String
    | CharacterPlaceholder
    | ObjectPlaceholder


type StoryPage
    = StoryPage (List StoryComponent)


type StoryTemplate
    = StoryTemplate (List StoryPage)


type Story
    = Story StoryTemplate Character Object


someoneLosesSomething : StoryTemplate
someoneLosesSomething =
    StoryTemplate
        [ StoryPage
            [ Line "Once upon a time, "
            , CharacterPlaceholder
            , Line "was on the way to the library, when they noticed they'd lost their"
            , ObjectPlaceholder
            ]
        , StoryPage
            [ Line "This made"
            , CharacterPlaceholder
            , Line "really sad, because the"
            , ObjectPlaceholder
            , Line "was their favourite item."
            ]
        ]


storyToPages : Story -> List StoryPage
storyToPages (Story (StoryTemplate pages) _ _) =
    pages


characterFromStory : Story -> Character
characterFromStory (Story _ character _) =
    character


objectFromStory : Story -> Object
objectFromStory (Story _ _ object) =
    object


pageToString : Character -> Object -> StoryPage -> String
pageToString character object (StoryPage components) =
    String.join " " <| List.map (componentToString character object) components


componentToString : Character -> Object -> StoryComponent -> String
componentToString character object storyComponent =
    case storyComponent of
        Line line ->
            line

        CharacterPlaceholder ->
            characterToString character

        ObjectPlaceholder ->
            objectToString object


characterToString : Character -> String
characterToString (Character name) =
    name


objectToString : Object -> String
objectToString (Object objectName) =
    objectName


defaultStory : Story
defaultStory =
    Story someoneLosesSomething (Character "Pablo") (Object "laptop")



---- MODEL ----


type alias Model =
    { story : Story }


init : ( Model, Cmd Msg )
init =
    ( { story = defaultStory }, Cmd.none )



---- UPDATE ----


type Msg
    = PageReadRequested StoryPage
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ({ story } as model) =
    case msg of
        PageReadRequested storyPage ->
            let
                character =
                    characterFromStory story

                object =
                    objectFromStory story
            in
                ( model, sendStoryToRead <| pageToString character object storyPage )

        _ ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view { story } =
    div []
        (List.map
            (renderPage story)
         <|
            storyToPages story
        )


renderPage : Story -> StoryPage -> Html Msg
renderPage (Story _ character object) page =
    div [ onClick <| PageReadRequested page ]
        [ text <| pageToString character object page
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
