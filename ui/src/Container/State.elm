module Container.State exposing (init, update, subscriptions)

import Container.Types exposing (..)
import History.State
import Player.State
import Wallpaper.State


init : ( Model, Cmd Msg )
init =
    let
        ( history, historyCmd ) =
            History.State.init

        ( player, playerCmd ) =
            Player.State.init

        wallpaper =
            Wallpaper.State.init
    in
        ( Model history player wallpaper
        , Cmd.batch
            [ Cmd.map HistoryMsg historyCmd
            , Cmd.map PlayerMsg playerCmd
            ]
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HistoryMsg fMsg ->
            let
                ( history, historyCmd ) =
                    History.State.update fMsg model.history
            in
                ( { model | history = history }, Cmd.map HistoryMsg historyCmd )

        PlayerMsg fMsg ->
            let
                ( player, playerCmd ) =
                    Player.State.update fMsg model.player
            in
                ( { model | player = player }, Cmd.map PlayerMsg playerCmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map HistoryMsg (History.State.subscriptions model.history)
        , Sub.map PlayerMsg (Player.State.subscriptions model.player)
        ]
