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
                setLoading False model ! []

        GetRankComplete (Ok response) ->
            setLoading False { model | highestRank = response } ! []

        GetRank ->
            setLoading True model ! [ Api.doGetRank ]

        GetGithub ->
            setLoading True model ! [ Api.doGetGithub ]

        GetGithubComplete (Err err) ->
            let
                _ = Debug.log "ERROR" err
                --_ = Debug.crash "error getting github" err
            in
                setLoading False model ! []

        GetGithubComplete (Ok response) ->
            setLoading False { model | githubRows = response.result } ! []

        GetAggregated ->
            setLoading True model ! [ Api.doGetAggregated ]

        GetAggregatedComplete (Err err) ->
            let
                _ = Debug.log "ERROR" err
            in
                setLoading False model ! []

        GetAggregatedComplete (Ok response) ->
            setLoading False { model | aggregatedRows = response.result } ! []


setLoading : Bool -> Model -> Model
setLoading loading model =
    { model | loading = loading }
