module History.Types exposing (..)

import Http
import Time exposing (..)

type alias Song =
    { artist : String
    , title : String
    }

type alias Model =
    { history : List Song
    , popular : List Song
    , error : String
    }


type alias APIResponse =
    { nowplaying : List Song, popular: List Song }


type Msg
    = HistoryLoadedMsg (Result Http.Error APIResponse)
    | RequestHistoryMsg Time
