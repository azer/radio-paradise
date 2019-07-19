module History.View exposing (view)

import Css exposing (..)
import Css.Media
import History.Types exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, style, href, src, class, target)
import Regex
import String


view : Model -> Html Msg
view model =
    div [ historyStyle ]
        [ div [contentStyle]
              [ viewSongs "Now Playing" model.history nowPlayingRowStyle
              , viewSongs "Popular" (List.take 5 model.popular) []
              , viewFooter
              ]
        ]

viewSongs : String -> List Song -> List Style -> Html Msg
viewSongs title songs customStyle =
    div [ songsStyle ]
        [ h1 [ titleStyle ] [ text title ]
        , ul [ tableStyle ] (List.map (viewSong customStyle) songs)
        ]

viewSong : List Style -> Song -> Html Msg
viewSong customStyle song =
    li [ css [ Css.batch rowStyle, Css.batch customStyle
                    ] ]
    [ text (song.artist ++ " — " ++ song.title) ]


viewFooter : Html Msg
viewFooter =
    h2 [footerStyle]
       [ text "<"
       , link "http://kodfabrik.com" "Webmaster"
       , text ">"
       , text " <"
       , link "http://kodfabrik.com/photo/36821546343" "Photo"
       , text ">"
       , text " <"
       , link "http://radioparadise.com" "RP"
       , text ">"
       , text " <"
       , link "https://github.com/azer/radio-paradise" "CODE"
       , text ">"
       ]


link : String -> String -> Html Msg
link url label =
    a [css [ color (rgba 255 255 255 0.8), textDecoration none ]
      , href url
      , Html.Styled.Attributes.target "_blank"]
      [text label]

footerStyle : Attribute Msg
footerStyle =
    css
        [ fontSize (px 14)
        , lineHeight (Css.em 1.4)
        , fontFamilies [ "Apercu Mono", "sans-serif" ]
        , textTransform uppercase
        , fontWeight normal
        , property "margin" "100px 0 0 0"
        , color (rgba 255 255 255 0.4)
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ fontSize (px 12) ]
        ]

titleStyle : Attribute msg
titleStyle =
    css
        [ fontSize (px 18)
        , lineHeight (Css.em 1)
        , fontFamilies [ "Apercu Mono", "sans-serif" ]
        , textTransform uppercase
        , fontWeight normal
        , property "margin" "0 0 5px 0"
        , padding (px 0)
        , color (rgba 255 255 255 0.3)
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ fontSize (px 14) ]
        ]


historyStyle : Attribute msg
historyStyle =
    css
        [ display block
        , position absolute
        , width (pct 100)
        , height (pct 100)
        , top (px 0)
        , left (px 0)

        --, justifyContent center
        --, alignItems center
        , zIndex (int 1)
        , fontFamilies [ "TiemposHeadline", "Georgia", "serif" ]
        , fontSize (px 21)
        , backgroundColor (rgba 0 0 0 0.2)
        , fontWeight normal
        ]

songsStyle : Attribute Msg
songsStyle =
    css [ property "margin" "100px 0 0 0"
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ property "margin" "50px 0 0 0" ]]


contentStyle : Attribute msg
contentStyle =
    css
        [ property "margin" "100px 0 0 140px"
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ property "margin" "0 0 0 50px" ]
        ]

tableStyle : Attribute msg
tableStyle =
    css
        [ margin (px 0)
        , padding (px 0)
        ]

rowStyle : List Style
rowStyle =
        [ listStyle none
        , color (rgba 255 255 255 0.7)
        , lineHeight (Css.em 1.4)
        , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ fontSize (px 14) ]
        ]

nowPlayingRowStyle : List Style
nowPlayingRowStyle =
    [ firstChild
         [ color (rgb 255 255 255)
         , fontSize (px 32)
         , lineHeight (Css.em 1.7)
         , Css.Media.withMedia [ Css.Media.all [ Css.Media.maxWidth (px 800) ] ]
            [ fontSize (px 18) ]
         ]
    ]
