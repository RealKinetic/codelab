module Api exposing (..)

import Http
import Json.Decode as JD

import Aggregated
import BigQuery
import HackerNews
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

getAggregatedUrl : String
getAggregatedUrl =
    getGithubUrl ++ "/aggregated"

getAggregated : Http.Request Aggregated.Result
getAggregated =
    Http.get getAggregatedUrl Aggregated.resultResponseDecoder

doGetAggregated : Cmd Msg
doGetAggregated =
    Http.send GetAggregatedComplete getAggregated


getHackerNewsUrl : String
getHackerNewsUrl =
    "/highest_seen"

getHackerNews : Http.Request HackerNews.Result
getHackerNews =
    Http.get getHackerNewsUrl HackerNews.getRowsResponseDecoder

doGetHackerNews : Cmd Msg
doGetHackerNews =
    Http.send GetHackerNewsComplete getHackerNews
