module StoryTime.StoryProgress
    exposing
        ( StoryProgress(..)
        , ReadingProgress(..)
        , getCurrentPage
        , resetReadingProgress
        , startStory
        , turnPage
        , currentPageToString
        )

import StoryTime.Story
    exposing
        ( Story(..)
        , StoryTemplate
        , StoryPage
        , Character(..)
        , Object(..)
        , defaultStory
        , getFirstPage
        , getNextPage
        , pageToString
        )


type StoryProgress
    = StoryProgress Story ReadingProgress


type ReadingProgress
    = NotStarted
    | InProgress StoryPage
    | Finished


startStory : Story -> StoryProgress
startStory story =
    StoryProgress story NotStarted


turnPage : StoryProgress -> StoryProgress
turnPage (StoryProgress story progress) =
    case progress of
        NotStarted ->
            getFirstPage story
                |> Maybe.map InProgress
                |> Maybe.withDefault Finished
                |> StoryProgress story

        InProgress currentPage ->
            getNextPage story currentPage
                |> Maybe.map InProgress
                |> Maybe.withDefault Finished
                |> StoryProgress story

        Finished ->
            StoryProgress story Finished


getCurrentPage : StoryProgress -> Maybe StoryPage
getCurrentPage (StoryProgress _ readingProgress) =
    case readingProgress of
        InProgress page ->
            Just page

        _ ->
            Nothing


resetReadingProgress : StoryProgress -> StoryProgress
resetReadingProgress (StoryProgress story _) =
    StoryProgress story NotStarted


currentPageToString : StoryProgress -> Maybe String
currentPageToString (StoryProgress story readingProgress) =
    case readingProgress of
        InProgress page ->
            Just <| pageToString story page

        _ ->
            Nothing
