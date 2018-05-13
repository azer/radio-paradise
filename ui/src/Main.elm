module App exposing (main)

import Html
import Container.State exposing (..)
import Container.View exposing (..)
import Container.Types exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
