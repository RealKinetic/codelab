module Model exposing (..)

import BigQuery
import Message exposing (Msg)
import Routes exposing (Sitemap(..))


type alias Model =
    { route : Sitemap
    , highestRank : Int
    , githubRows : List BigQuery.Row
    }

init : ( Model, Cmd Msg )
init =
    { route = Home
    , highestRank = 0
    , githubRows = []
    } ! [ Cmd.none ]
