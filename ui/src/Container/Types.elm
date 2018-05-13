module Container.Types exposing (..)

import History.Types
import Player.Types
import Wallpaper.Types


type alias Model =
    { history : History.Types.Model
    , player : Player.Types.Model
    , wallpaper : Wallpaper.Types.Model
    }


type Msg
    = HistoryMsg History.Types.Msg
    | PlayerMsg Player.Types.Msg
