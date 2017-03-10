module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as JD

import Aggregated
import BigQuery
import HackerNews
import Message exposing (Msg(..))
import Model exposing (Model)
import Routes exposing (..)


link : Sitemap -> String -> String -> Bool -> Html Msg
link route icon label expandable =
    let
        opts =
            { preventDefault = True, stopPropagation = True }
    in
        Html.a
            [ href (Routes.toString route)
            , Html.Events.onWithOptions "click" opts (JD.succeed <| RouteTo route)
            ]
            [ Html.i [ class icon ] []
            , Html.text label
            ]


nav : Model -> Html Msg
nav model =
    let
        children =
            if model.loading then
                [ Html.li [] [ link Home "fa fa-fw fa-desktop" "Rank" False ]
                , Html.li [] [ link MySQL "fa fw-fw fa-table" "Bigquery" False ]
                , Html.li [] [ link Aggregated "fa fa-fw fa-dashboard" "Aggregated" False ]
                , Html.li [] [ link HackerNews "fa fa-fw fa-wrench" "HackerNews" False ]
                , Html.li [] [ Html.span [ style [("margin-left", "20px"), ("color", "white")] ] [Html.text "LOADING"] ]
                ]
            else
                [ Html.li [] [ link Home "fa fa-fw fa-desktop" "Rank" False ]
                , Html.li [] [ link MySQL "fa fw-fw fa-table" "Bigquery" False ]
                , Html.li [] [ link Aggregated "fa fa-fw fa-dashboard" "Aggregated" False ]
                , Html.li [] [ link HackerNews "fa fa-fw fa-wrench" "HackerNews Avg" False ]
                ]
    in
        Html.nav
            [ class "navbar navbar-inverse navbar-fixed-top"
            ]
            [ Html.div [ class "navbar-header" ]
                [ Html.span [ class "navbar-brand" ] [ Html.text "Codelab" ]
                ]
            , Html.ul [ class "nav navbar-nav side-nav" ]
                children
            ]


home : Model -> Html Msg
home model =
    Html.div []
        [ Html.button [ Html.Events.onClick GetRank ] [ Html.text "Get Rank" ]
        , Html.div [ class "panel panel-default" ]
            [ Html.div [ class "panel-body" ]
                [ Html.text (Basics.toString model.highestRank)
                ]
            ]
        ]


mapToRow : BigQuery.Row -> Html Msg
mapToRow row =
    Html.tr []
        [ Html.td [] [ Html.text row.repo ]
        , Html.td [] [ Html.text row.language ]
        , Html.td [] [ Html.text (Basics.toString row.bytes) ]
        ]


mysql : Model -> Html Msg
mysql model =
    Html.div []
        [ Html.button [ Html.Events.onClick GetGithub ] [ Html.text "Get Github Results" ]
        , Html.div [ class "table table-bordered table-hover" ]
            [ Html.thead [] [ Html.tr [] [Html.th [] [Html.text "repo"], Html.th [] [Html.text "language"], Html.th [] [Html.text "bytes"] ] ]
            , Html.tbody []
                (List.map mapToRow model.githubRows)
            ]
        ]


mapToAggregated : Aggregated.Row -> Html Msg
mapToAggregated row =
    Html.tr []
        [ Html.td [] [ Html.text row.language ]
        , Html.td [] [ Html.text (Basics.toString row.totalBytes) ]
        ]


aggregated : Model -> Html Msg
aggregated model =
    Html.div []
        [ Html.button [ Html.Events.onClick GetAggregated ] [ Html.text "Get Github Aggregated Results" ]
        , Html.div [ class "table table-bordered table-hover" ]
            [ Html.thead [] [ Html.tr [] [Html.th [] [Html.text "language"], Html.th [] [Html.text "total bytes"] ] ]
            , Html.tbody []
                (List.map mapToAggregated model.aggregatedRows)
            ]
        ]


mapToHackerNews : HackerNews.Row -> Html Msg
mapToHackerNews row =
    Html.tr []
        [ Html.td [] [ Html.text row.word ]
        , Html.td [] [ Html.text (Basics.toString row.average) ]
        ]


hackernews : Model -> Html Msg
hackernews model =
    Html.div []
        [ Html.button [ Html.Events.onClick GetHackerNews ] [ Html.text "Get HackerNews Ranks" ]
        , Html.div [ class "table table-bordered table-hover" ]
            [ Html.thead [] [ Html.tr [] [Html.th [] [Html.text "word"], Html.th [] [Html.text "average"] ] ]
            , Html.tbody []
                (List.map mapToHackerNews model.hackerRows)
            ]
        ]


content : Model -> Html Msg
content model =
    let
        content =
            case model.route of
                Home ->
                    home model
                MySQL ->
                    mysql model
                Aggregated ->
                    aggregated model
                HackerNews ->
                    hackernews model
                NotFound ->
                    home model
    in
        Html.div [ id "page-wrapper", style [ ("min-height", "298px") ] ]
            [ content ]


view : Model -> Html Msg
view model =
    Html.div
        [ id "wrapper" ]
        [ nav model
        , content model
        ]
