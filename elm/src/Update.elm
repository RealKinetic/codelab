module Update exposing (..)

import Message exposing (Msg(..))
import Model exposing (Model)
import Routes exposing (navigateTo, Sitemap)

handleRoute : Sitemap -> Model -> ( Model, Cmd Msg )
handleRoute route m =
    let
        model = { m | route = route }
    in
        model ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RouteChanged route ->
            handleRoute route model

        RouteTo route ->
            model ! [ navigateTo route ]
