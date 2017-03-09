module Update exposing (..)

import Api
import Message exposing (Msg(..))
import Model exposing (Model)
import Routes exposing (navigateTo, Sitemap)

handleRoute : Sitemap -> Model -> ( Model, Cmd Msg )
handleRoute route m =
    let
        model = { m | route = route }
    in
        model ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RouteChanged route ->
            handleRoute route model

        RouteTo route ->
            model ! [ navigateTo route ]

        GetRankComplete (Err _) ->
            let
                _ = Debug.crash "error getting rank"
            in
                model ! []

        GetRankComplete (Ok response) ->
            { model | highestRank = response } ! []

        GetRank ->
            model ! [ Api.doGetRank ]

        GetGithub ->
            model ! [ Api.doGetGithub ]

        GetGithubComplete (Err err) ->
            let
                _ = Debug.log "ERROR" err
                --_ = Debug.crash "error getting github" err
            in
                model ! []

        GetGithubComplete (Ok response) ->
            { model | githubRows = response.result } ! []