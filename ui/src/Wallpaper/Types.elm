module Wallpaper.Types exposing (..)


type alias File =
    { size : Float
    , url : String
    }


type alias Image =
    { position : String
    , sources : List File
    }


type alias Model =
    { image : Image
    , error : String
    }
