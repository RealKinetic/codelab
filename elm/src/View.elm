module View exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode as JD

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
    Html.nav
        [ class "navbar navbar-inverse navbar-fixed-top"
        ]
        [ Html.div [ class "navbar-header" ]
            [ Html.span [ class "navbar-brand" ] [ Html.text "Codelab" ]
            ]
        , Html.ul [ class "nav navbar-nav side-nav" ]
            [ Html.li [] [ link Home "fa fa-fw fa-desktop" "Home" False ]
            , Html.li [] [ link MySQL "fa fw-fw fa-table" "Cloud SQL" False ]
            ]
        ]


home : Model -> Html Msg
home model =
    Html.div [] [ Html.text "HOME" ]


mysql : Model -> Html Msg
mysql model =
    Html.div [] [ Html.text "Cloud SQL" ]


content : Model -> Html Msg
content model =
    let
        content =
            case model.route of
                Home ->
                    home model
                MySQL ->
                    mysql model
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
