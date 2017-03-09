module Api exposing (..)

import Http
import Json.Decode as JD

import BigQuery
import Message exposing (Msg(..))


getRankUrl : String
getRankUrl =
    "/rank"


getRank : Http.Request Int
getRank =
    Http.get getRankUrl JD.int


doGetRank : Cmd Msg
doGetRank =
    Http.send GetRankComplete getRank

getGithubUrl : String
getGithubUrl =
    "/big_query/languages"

getGithub : Http.Request BigQuery.Result
getGithub =
    Http.get getGithubUrl BigQuery.getRowsResponseDecoder

doGetGithub : Cmd Msg
doGetGithub =
    Http.send GetGithubComplete getGithub