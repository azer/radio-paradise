module History.Rest exposing (..)

import History.Types exposing (..)
import Json.Decode as Decode
import Http


requestLatestHistory : Cmd Msg
requestLatestHistory =
    Http.send HistoryLoadedMsg (Http.get "/api/now" responseDecoder)


responseDecoder : Decode.Decoder APIResponse
responseDecoder =
    Decode.map2 APIResponse
        (Decode.field "nowplaying" (Decode.list songDecoder))
        (Decode.field "popular" (Decode.list songDecoder))


songDecoder : Decode.Decoder Song
songDecoder =
    Decode.map2 Song
        (Decode.field "artist" Decode.string)
        (Decode.field "title" Decode.string)
