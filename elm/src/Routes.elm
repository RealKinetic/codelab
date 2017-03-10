module Routes exposing (..)

import String

import Navigation exposing (Location)
import Route exposing (..)


type Sitemap
    = Home
    | MySQL
    | NotFound
    | Aggregated
    | HackerNews


home =
    Home := static ""


mysql =
    MySQL := static "mysql"

aggregated =
    Aggregated := static "aggregated"

hackernews =
    HackerNews := static "hackernews"


sitemap =
    router [ home, mysql, aggregated, hackernews ]


match : String -> Sitemap
match =
    String.dropLeft 1 >> Route.match sitemap >> Maybe.withDefault NotFound


toString : Sitemap -> String
toString r =
    let
        route =
            case r of
                Home ->
                    reverse home []
                MySQL ->
                    reverse mysql []
                Aggregated ->
                    reverse aggregated []
                HackerNews ->
                    reverse hackernews []
                NotFound ->
                    Debug.crash "cannot render notfound"
    in
        "#" ++ route


parsePath : Location -> Sitemap
parsePath =
    .hash >> match


navigateTo : Sitemap -> Cmd msg
navigateTo =
    toString >> Navigation.newUrl
