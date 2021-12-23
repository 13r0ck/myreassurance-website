-- Copy pasted from andrewMacmurray/elm-simple-animation/main/examples. Thank you!


module Wheel exposing (progress)

import Element exposing (Element)
import Hex
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import Svg exposing (Svg)
import Svg.Attributes exposing (..)
import Utils.Animated as Animated



-- Animation


animateProgressLine : Int -> Animation
animateProgressLine percent =
    Animation.fromTo
        { duration = 500
        , options = []
        }
        [ P.property "stroke-dashoffset" (offset 0) ]
        [ P.property "stroke-dashoffset" (offset percent) ]


offset : Int -> String
offset percent =
    String.fromFloat (circumference * (1 - toFloat percent / 100))



-- Progress Wheel


progress : Int -> Element.Color -> Element msg
progress percent c =
    Element.el [ Element.width Element.fill ]
        (Element.html
            (Svg.svg [ width "100%", viewBox_ ]
                [ progressCircle percent (toHexCode c)
                ]
            )
        )


toHexCode c =
    Element.toRgb c
        |> (\rgb ->
                String.concat
                    [ "#"
                    , rgb.red |> to255 |> Hex.toString |> add0
                    , rgb.green |> to255 |> Hex.toString |> add0
                    , rgb.blue |> to255 |> Hex.toString |> add0
                    ]
           )


to255 val =
    if val == 1.0 then
        255

    else
        val * 256.0 |> floor


add0 s =
    if String.length s < 2 then
        "0" ++ s

    else
        s


progressCircle : Int -> String -> Svg msg
progressCircle percent hexColor =
    Svg.g
        [ transform "rotate(90)"
        , style originCenter
        ]
        [ Svg.circle
            [ stroke "#FFFFFF"
            , fill "none"
            , cx "60"
            , cy "60"
            , r (String.fromFloat radius)
            , strokeWidth_
            ]
            []
        , Animated.circle (animateProgressLine percent)
            [ fill "none"
            , stroke hexColor
            , strokeLinecap "round"
            , strokeDasharray (String.fromFloat circumference)
            , cx "60"
            , cy "60"
            , r (String.fromFloat radius)
            , strokeWidth2_
            ]
            []
        ]



-- Helpers


strokeWidth_ : Svg.Attribute msg
strokeWidth_ =
    strokeWidth (String.fromInt 3)


strokeWidth2_ : Svg.Attribute msg
strokeWidth2_ =
    strokeWidth (String.fromInt 4)


viewBox_ : Svg.Attribute msg
viewBox_ =
    viewBox
        (join
            [ "0 0 "
            , String.fromFloat viewboxWidth
            , String.fromFloat viewboxHeight
            ]
        )


originCenter : String
originCenter =
    join
        [ "transform-origin:"
        , px (viewboxHeight / 2)
        , px (viewboxWidth / 2)
        ]


px : Float -> String
px n =
    String.fromFloat n ++ "px"


join : List String -> String
join =
    String.join " "



-- Config


radius : Float
radius =
    54


circumference : Float
circumference =
    2 * pi * radius


viewboxHeight : Float
viewboxHeight =
    120


viewboxWidth : Float
viewboxWidth =
    120
