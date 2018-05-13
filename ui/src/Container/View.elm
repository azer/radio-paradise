module Container.View exposing (view)

import Container.Types exposing (..)
import History.Types
import History.View
import Html exposing (..)
import Html.Styled
import Player.Types
import Player.View
import Wallpaper.View


view : Model -> Html Msg
view model =
    div []
        [ History.View.view model.history
            |> Html.Styled.toUnstyled
            |> Html.map HistoryMsg
        , Player.View.view model.player
            |> Html.Styled.toUnstyled
            |> Html.map PlayerMsg
        , Wallpaper.View.view model.wallpaper
            |> Html.Styled.toUnstyled
        ]
