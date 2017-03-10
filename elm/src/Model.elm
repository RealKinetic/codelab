module Model exposing (..)

import Aggregated
import BigQuery
import HackerNews
import Message exposing (Msg)
import Routes exposing (Sitemap(..))


type alias Model =
    { route : Sitemap
    , highestRank : Int
    , githubRows : List BigQuery.Row
    , aggregatedRows : List Aggregated.Row
    , loading : Bool
    , hackerRows : List HackerNews.Row
    }

init : ( Model, Cmd Msg )
init =
    { route = Home
    , highestRank = 0
    , githubRows = []
    , aggregatedRows = []
    , loading = False
    , hackerRows = []
    } ! [ Cmd.none ]
