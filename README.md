# README #

# The Daily News #
This README would normally document decribes the implementation of The Daily News App. In this app no third parties were used.The news information is fetched from "https://newsapi.org/docs/endpoints"

## Tech Stack & Tool ##
1. Completely implemented in swift.
2. Complete Programmatic UI. Storyboard and xib's were not used.
3. Added unit tests and UITests whereever needed.

## Design Pattern ##
1. Implemented The Daily News App app following MVVM-C Design pattern.
2. Segregated network layer for easy Maintainence.
3. Every controller will have fetcher(fetches data from server based on network availability), 
   ViewModel(Process the data), ViewController(To display in UI).

## Use Cases ##
1. On launch of the application we are fetching news data from server and displaying news list in UI(with title, description and image).
2. Implemented Pull to refresh.
3. Implemented pagination.
4. On selection of news, news details page is displayed with complete description.

## Other features ##
1. Designed UI to support multiple device sizes (iPhone, iPad, portrait, landscape).
2. Added app icon.

## Coding Standards ##
1. Ensured Zero Warning.
2. Added Documentation whereever necessary.
3. Code segregation.
