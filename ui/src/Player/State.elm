port module Player.State exposing (init, update, subscriptions)

import Player.Types exposing (..)
import Keyboard
import Debug


sources : List File
sources =
    [ File "audio/mp3" 192 "http://stream-tx4.radioparadise.com/mp3-192"
    , File "audio/ogg" 192 "http://stream-tx4.radioparadise.com/ogg-192"
    , File "audio/aac" 128 "http://stream-tx4.radioparadise.com/aac-128"
    ]


init : ( Model, Cmd Msg )
init =
    ( Model False True sources "", Cmd.none)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "[player]" msg of
        PlayMsg ->
            ({ model | loading = False }, Cmd.none)

        PauseMsg ->
            ({ model | loading = True }, forcePlay True)

        MuteMsg ->
            ( { model | muted = True }, setAsMuted True )

        UnmuteMsg ->
            ( { model | muted = False }, setAsMuted False )

        ToggleMuteMsg ->
            ( { model | muted = not model.muted }, setAsMuted (not model.muted) )

        LoadingMsg ->
            ( { model | loading = True }, Cmd.none )

        ErrorMsg ->
            ( { model | loading = True }, Cmd.none )

        KeyMsg code ->
            if code == 32 then
                ( { model | muted = not model.muted }, setAsMuted (not model.muted) )
            else
                ( model, Cmd.none )

subscriptions : Model -> Sub Msg
subscriptions model =
    Keyboard.downs KeyMsg

port setAsMuted : Bool -> Cmd msg
port forcePlay : Bool -> Cmd msg
