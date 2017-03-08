module Main exposing (..)

import Html exposing (Html)

import Navigation exposing (Location)

import Message
import Model
import Routes
import Update
import View


parseRoute : Location -> Message.Msg
parseRoute =
    Routes.parsePath >> Message.RouteChanged


init : Location -> ( Model.Model, Cmd Message.Msg )
init location =
    let
        route =
            Routes.parsePath location

        ( model, _ ) =
            Model.init

    in
        Update.handleRoute route
            { model | route = route }


main : Program Never Model.Model Message.Msg
main =
    Navigation.program parseRoute
        { init = init
        , update = Update.update
        , subscriptions = \_ -> Sub.none
        , view = View.view
        }
