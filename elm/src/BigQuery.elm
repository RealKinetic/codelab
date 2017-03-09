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
        |> required "repo" string
        |> required "language" string
        |> required "bytes" int


getRowsResponseDecoder : Decoder Result
getRowsResponseDecoder =
    decode Result
        |> required "result" (list rowResponseDecoder)
