module StoryTime.Story
    exposing
        ( Character(..)
        , Object(..)
        , Story(..)
        , StoryPage
        , StoryTemplate
        , characterFromStory
        , defaultStory
        , findTemplateByNameString
        , objectFromStory
        , pageToString
        , storyToPages
        , templateNames
        )

import List.Extra


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


type StoryName
    = StoryName String


type StoryTemplate
    = StoryTemplate StoryName (List StoryPage)


type Story
    = Story StoryTemplate Character Object


storyToPages : Story -> List StoryPage
storyToPages (Story (StoryTemplate _ pages) _ _) =
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


findTemplateByName : StoryName -> Maybe StoryTemplate
findTemplateByName name =
    List.Extra.find (hasMatchingName name) templates


findTemplateByNameString : String -> Maybe StoryTemplate
findTemplateByNameString =
    findTemplateByName << StoryName


hasMatchingName : StoryName -> StoryTemplate -> Bool
hasMatchingName matchingName (StoryTemplate name _) =
    matchingName == name


storyTemplateNameString : StoryTemplate -> String
storyTemplateNameString (StoryTemplate (StoryName name) _) =
    name


templates : List StoryTemplate
templates =
    [ someoneLosesSomething, birthdayParty ]


templateNames : List String
templateNames =
    List.map storyTemplateNameString templates


someoneLosesSomething : StoryTemplate
someoneLosesSomething =
    StoryTemplate
        (StoryName "Someone loses something")
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


birthdayParty : StoryTemplate
birthdayParty =
    StoryTemplate
        (StoryName "Birthday Party")
        [ StoryPage
            [ Line "Once upon a time, "
            , CharacterPlaceholder
            , Line "had a birthday party."
            ]
        , StoryPage
            [ Line "There was a big cake, and lots of presents for "
            , CharacterPlaceholder
            , Line "including a"
            , ObjectPlaceholder
            ]
        ]
