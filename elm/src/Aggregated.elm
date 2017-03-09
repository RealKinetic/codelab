module Aggregated exposing (..)

import Json.Decode exposing (list, Decoder, string, int)
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Row =
    { language : String
    , totalBytes : Int
    }


rowDecoder : Decoder Row
rowDecoder =
    decode Row
        |> optional "language" string ""
        |> optional "total_bytes" int 0


type alias Result =
    { result : List Row
    }

resultResponseDecoder : Decoder Result
resultResponseDecoder =
    decode Result
        |> required "result" (list rowDecoder)
