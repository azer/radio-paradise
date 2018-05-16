module Player.View exposing (view)

import Css exposing (..)
import Css.Media
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (src, type_, controls, autoplay, css)
import Html.Styled.Events exposing (onClick)
import Player.Events exposing (..)
import Player.Icons as Icons
import Player.Types exposing (..)

view : Model -> Html Msg
view model =
    div
        [ onClick ToggleMsg
        , playerStyle
        ]
        [ viewAudio model
        , viewButton model
        ]


viewAudio : Model -> Html Msg
viewAudio model =
    audio
        [ controls False
        , autoplay False
        , onPlay PlayMsg
        , onPause PauseMsg
        , onEnd PauseMsg
        , onSuspend PauseMsg
        , onStalled LoadingMsg
        , onError ErrorMsg
        ]
        (List.map viewSource model.sources)


viewButton : Model -> Html Msg
viewButton model =
    if model.idle then
        Icons.play 32
    else if model.loading then
        Icons.spinner
    else if model.muted then
        Icons.mute 32
    else
        Icons.volume 32


viewSource : File -> Html Msg
viewSource file =
    source
        [ src file.url
        , type_ file.format
        ]
        []


playerStyle : Attribute msg
playerStyle =
    css
        [ display block
        , position absolute
        , top (px 136)
        , left (px 90)
        , zIndex (int 2)
        , color (rgba 255 255 255 0.3)
        , cursor pointer
        , hover
            [ color (rgba 255 255 255 0.5)
            ]
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ top (px 69)
            , left (px 10) ]
        ]
