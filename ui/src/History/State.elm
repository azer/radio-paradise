module History.State exposing (init, subscriptions, update)

import History.Types exposing (..)
import History.Rest as Rest
import Task
import Time exposing (..)


init : ( Model, Cmd Msg )
init =
    ( Model [] [] "", Task.perform RequestHistoryMsg Time.now )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RequestHistoryMsg time ->
            ( model, Rest.requestLatestHistory )

        HistoryLoadedMsg (Ok response) ->
            ( Model response.nowplaying response.popular "", Cmd.none )

        HistoryLoadedMsg (Err err) ->
            ( { model | error = (toString err) }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (second * 10) RequestHistoryMsg
