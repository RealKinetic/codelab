module Model exposing (..)

import Aggregated
import BigQuery
import Message exposing (Msg)
import Routes exposing (Sitemap(..))


type alias Model =
    { route : Sitemap
    , highestRank : Int
    , githubRows : List BigQuery.Row
    , aggregatedRows : List Aggregated.Row
    }

init : ( Model, Cmd Msg )
init =
    { route = Home
    , highestRank = 0
    , githubRows = []
    , aggregatedRows = []
    } ! [ Cmd.none ]
