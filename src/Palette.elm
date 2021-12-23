module Palette exposing (..)

import Element exposing (Attr, Device, DeviceClass(..), Orientation(..))
import Element.Font as Font


text_xs device =
    fontSize device Xsm


text_sm device =
    fontSize device Sm


text_md device =
    fontSize device Md


text_lg device =
    fontSize device Lg


text_xl device =
    fontSize device Xl


text_2xl device =
    fontSize device XXl


classifyDevice : { window | height : Int, width : Int } -> Device
classifyDevice window =
    -- Tested in this ellie:
    -- https://ellie-app.com/68QM7wLW8b9a1
    { class =
        let
            width =
                window.width

            longSide =
                max window.width window.height

            shortSide =
                min window.width window.height
        in
        if width <= 600 then
            Phone

        else if width > 600 && width <= 1200 then
            Tablet

        else if width > 1200 && width <= 1920 then
            Desktop

        else
            BigDesktop
    , orientation =
        if window.width < window.height then
            Portrait

        else
            Landscape
    }


isTabletOrSmaller device =
    device == Phone || device == Tablet


isPhone device =
    device == Phone


type FontSize
    = Xsm
    | Sm
    | Md
    | Lg
    | Xl
    | XXl


fontSize : DeviceClass -> FontSize -> Attr decorative msg
fontSize device size =
    Font.size
        (case device of
            Phone ->
                case size of
                    Xsm ->
                        13

                    Sm ->
                        20

                    Md ->
                        25

                    Lg ->
                        38

                    Xl ->
                        45

                    XXl ->
                        45

            Tablet ->
                case size of
                    Xsm ->
                        13

                    Sm ->
                        20

                    Md ->
                        25

                    Lg ->
                        38

                    Xl ->
                        45

                    XXl ->
                        60

            Desktop ->
                case size of
                    Xsm ->
                        18

                    Sm ->
                        25

                    Md ->
                        30

                    Lg ->
                        43

                    Xl ->
                        50

                    XXl ->
                        80

            BigDesktop ->
                case size of
                    Xsm ->
                        18

                    Sm ->
                        25

                    Md ->
                        30

                    Lg ->
                        43

                    Xl ->
                        50

                    XXl ->
                        80
        )
