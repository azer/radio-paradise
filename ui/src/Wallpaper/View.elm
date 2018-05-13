module Wallpaper.View exposing (view)

import Css exposing (..)
import Css.Media
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, style, href, src)
import Wallpaper.Types exposing (..)


view : Model -> Html msg
view model =
    div
        [ viewStyle model.image
        ]
        []


viewStyle : Image -> Attribute msg
viewStyle image =
    css
        [ display block
        , position fixed
        , width (pct 100)
        , height (pct 100)
        , top (px 0)
        , left (px 0)
        , backgroundSize cover
        , backgroundRepeat noRepeat
        , property "background-position" image.position
        , zIndex (int 0)
        , Css.batch (List.map imageStyle image.sources)
        ]


imageStyle : File -> Style
imageStyle source =
    Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px source.size) ] ]
        [ backgroundImage (url source.url) ]
