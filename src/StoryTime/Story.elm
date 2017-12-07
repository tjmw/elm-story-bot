module StoryTime.Story
    exposing
        ( Character(..)
        , Story
        , StoryPage
        , StoryTemplate
        , characterFromStory
        , defaultStory
        , objectFromStory
        , pageToString
        , storyToPages
        )


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


storyToPages : Story -> List StoryPage
storyToPages (Story (StoryTemplate pages) _ _) =
    pages


characterFromStory : Story -> Character
characterFromStory (Story _ character _) =
    character


objectFromStory : Story -> Object
objectFromStory (Story _ _ object) =
    object


pageToString : Story -> StoryPage -> String
pageToString (Story _ character object) (StoryPage components) =
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
