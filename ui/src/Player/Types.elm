module Player.Types exposing (..)

import Keyboard


type alias File =
    { format : String
    , quality : Int
    , url : String
    }


type alias Model =
    { idle : Bool
    , muted : Bool
    , loading : Bool
    , sources : List File
    , error : String
    }


type Msg
    = MuteMsg
    | UnmuteMsg
    | ToggleMsg
    | PlayMsg
    | PauseMsg
    | LoadingMsg
    | ErrorMsg
    | KeyMsg Keyboard.KeyCode
