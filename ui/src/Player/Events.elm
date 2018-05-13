module Player.Events exposing (..)

import Html.Styled exposing (Attribute)
import Html.Styled.Events exposing (on)
import Json.Decode as Json

onPlay : msg -> Attribute msg
onPlay message  =
    on "play" (Json.succeed message)

onPause : msg -> Attribute msg
onPause message  =
    on "pause" (Json.succeed message)

onPaused : msg -> Attribute msg
onPaused message  =
    on "paused" (Json.succeed message)

onEnd : msg -> Attribute msg
onEnd message  =
    on "ended" (Json.succeed message)

onSuspend : msg -> Attribute msg
onSuspend message  =
    on "suspend" (Json.succeed message)

onSeeking : msg -> Attribute msg
onSeeking message  =
    on "seeking" (Json.succeed message)

onError : msg -> Attribute msg
onError message  =
    on "error" (Json.succeed message)

onStalled : msg -> Attribute msg
onStalled message  =
    on "stalled" (Json.succeed message)

onCanPlayThrough : msg -> Attribute msg
onCanPlayThrough message  =
    on "canplaythrough" (Json.succeed message)
