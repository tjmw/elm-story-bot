module StoryTime.Update exposing (init, update)

import StoryTime.Ports exposing (sendStoryToRead)
import StoryTime.Story
    exposing
        ( characterFromStory
        , defaultStory
        , objectFromStory
        , pageToString
        )
import StoryTime.Types exposing (Model, Msg(..))


init : ( Model, Cmd Msg )
init =
    ( { story = defaultStory }, Cmd.none )


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
