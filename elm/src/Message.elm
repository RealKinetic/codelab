module Message exposing (..)

import Routes exposing (Sitemap)


type Msg
    = RouteChanged Sitemap
    | RouteTo Sitemap
