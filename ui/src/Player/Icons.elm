module Player.Icons exposing (..)

import Html.Styled exposing (Html)
import Svg.Styled exposing (..)
import Svg.Styled.Attributes exposing (..)


mute : Int -> Html msg
mute size =
    icon size "M20 16 C20 8 15 2 15 2 L8 10 2 10 2 22 8 22 15 30 C15 30 20 24 20 16 Z"


volume : Int -> Html msg
volume size =
    icon size "M20 16 C20 8 15 2 15 2 L8 10 2 10 2 22 8 22 15 30 C15 30 20 24 20 16 Z M21 2 C21 2 25 6 25 16 25 26 21 30 21 30 M27 4 C27 4 30 8 30 16 30 24 27 28 27 28"

play_ : Int -> Html msg
play_ size =
    icon size "M10 2 L10 30 24 16 Z"

icon : Int -> String -> Html msg
icon size data =
    let
        w =
            (toString size)
    in
        svg
            [ width w
            , height w
            , viewBox "0 0 32 32"
            , fill "none"
            , stroke "currentColor"
            , strokeLinecap "round"
            , strokeLinejoin "round"
            , strokeWidth "2"
            ]
            [ Svg.Styled.path
                [ d data ]
                []
            ]

play : Int -> Html msg
play size =
    svg [ width (toString size), height (toString size), viewBox "0 0 1200 1200" ]
        [ Svg.Styled.path [ fill "#fff"
               , opacity "0.9"
               , d "M 600,1200 C 268.65,1200 0,931.35 0,600 0,268.65 268.65,0 600,0 c 331.35,0 600,268.65 600,600 0,331.35 -268.65,600 -600,600 z M 450,300.45 450,899.55 900,600 450,300.45 z" ]
              []
        , text ""
        ]

spinner : Html msg
spinner =
    svg
        [ width "32px"
          , height "32px"
          , viewBox "0 0 40 40"
          , enableBackground "new 0 0 32 32"
          , x "0px"
          , y "0px"
        ]
        [ Svg.Styled.path
              [ opacity "0.2"
              , fill "#fff"
              , d "M20.201,5.169c-8.254,0-14.946,6.692-14.946,14.946c0,8.255,6.692,14.946,14.946,14.946 s14.946-6.691,14.946-14.946C35.146,11.861,28.455,5.169,20.201,5.169z M20.201,31.749c-6.425,0-11.634-5.208-11.634-11.634 c0-6.425,5.209-11.634,11.634-11.634c6.425,0,11.633,5.209,11.633,11.634C31.834,26.541,26.626,31.749,20.201,31.749z"
              ]
              []
        , Svg.Styled.path
              [ fill "#fff"
              , d "M26.013,10.047l1.654-2.866c-2.198-1.272-4.743-2.012-7.466-2.012h0v3.312h0 C22.32,8.481,24.301,9.057,26.013,10.047z"
              ]
            [ Svg.Styled.animateTransform
                  [ attributeType "xml"
                  , attributeName "transform"
                  , type_ "rotate"
                  , from "0 20 20"
                  , to "360 20 20"
                  , dur "0.5s"
                  , repeatCount "indefinite"
                  ][]
            ]
        ]
