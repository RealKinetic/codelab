module HackerNews exposing (..)

import Json.Decode exposing (list, Decoder, float, string, int)
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Row =
    { word : String
    , average : Float
    }

type alias Result =
    { result : List Row
    }


rowResponseDecoder : Decoder Row
rowResponseDecoder =
    decode Row
        |> optional "word" string ""
        |> optional "average" float 0.0


getRowsResponseDecoder : Decoder Result
getRowsResponseDecoder =
    decode Result
        |> required "result" (list rowResponseDecoder)
