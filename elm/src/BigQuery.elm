module BigQuery exposing (..)

import Json.Decode exposing (list, Decoder, string, int)
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Row =
    { repo : String
    , language : String
    , bytes : Int
    }

type alias Result =
    { result : List Row
    }


rowResponseDecoder : Decoder Row
rowResponseDecoder =
    decode Row
        |> optional "repo" string ""
        |> optional "language" string ""
        |> optional "bytes" int 0


getRowsResponseDecoder : Decoder Result
getRowsResponseDecoder =
    decode Result
        |> required "result" (list rowResponseDecoder)
