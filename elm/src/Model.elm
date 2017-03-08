module Model exposing (..)

import Message exposing (Msg)
import Routes exposing (Sitemap(..))


type alias Model =
    { route : Sitemap
    }

init : ( Model, Cmd Msg )
init =
    { route = Home } ! [ Cmd.none ]
