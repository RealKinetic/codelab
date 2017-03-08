module Routes exposing (..)

import String

import Navigation exposing (Location)
import Route exposing (..)


type Sitemap
    = Home
    | MySQL
    | NotFound


home =
    Home := static ""


mysql =
    MySQL := static "mysql"


sitemap =
    router [ home, mysql ]


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
