module Message exposing (..)

import Http

import BigQuery
import Routes exposing (Sitemap)


type Msg
    = RouteChanged Sitemap
    | RouteTo Sitemap
    | GetRankComplete (Result Http.Error Int)
    | GetRank
    | GetGithub
    | GetGithubComplete (Result Http.Error BigQuery.Result)
