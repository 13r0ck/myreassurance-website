-- tailwind aliases for elm-ui


module Tailwind exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html
import Html.Attributes as Attributes
import Svg
import Svg.Attributes as Atr



-- Other


basefont =
    16


br =
    html <| Html.br [] []


style s v =
    htmlAttribute <| Attributes.style s v


rightArrow =
    html <|
        Svg.svg
            [ Atr.width "100%", Atr.height "100%", Atr.viewBox "0 0 20 20", Atr.fill "currentColor" ]
            [ Svg.path
                [ Atr.fillRule "evenodd"
                , Atr.clipRule "evenodd"
                , Atr.d "M10.293 15.707a1 1 0 010-1.414L14.586 10l-4.293-4.293a1 1 0 111.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z"
                ]
                []
            , Svg.path
                [ Atr.fillRule "evenodd"
                , Atr.clipRule "evenodd"
                , Atr.d "M4.293 15.707a1 1 0 010-1.414L8.586 10 4.293 5.707a1 1 0 011.414-1.414l5 5a1 1 0 010 1.414l-5 5a1 1 0 01-1.414 0z"
                ]
                []
            ]


skyline =
    html <|
        Svg.svg
            [ Atr.width "100%", Atr.height "100%", Atr.viewBox "0 0 230.49237 57.565285", Atr.fill "currentColor" ]
            [ Svg.g
                [ Atr.transform "translate(-18.407316,-13.446063)" ]
                [ Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.strokeWidth "0.32"
                    , Atr.fillOpacity "1"
                    , Atr.d "m 18.407316,64.291349 c 0,-4.266666 0.116826,-6.72 0.32,-6.72 0.176,0 0.32,-0.409277 0.32,-0.909501 v -0.909504 l 5.811298,-0.210496 c 3.196214,-0.115776 6.724214,-0.210499 7.84,-0.210499 h 2.028702 v 3.2 3.2 h 1.581113 c 0.869613,0 1.670112,0.144 1.778887,0.32 0.108774,0.176 0.477273,0.32 0.818886,0.32 0.587104,0 0.621114,-0.261792 0.621114,-4.781114 0,-2.84223 -0.12977,-4.861318 -0.32,-4.978886 -0.417162,-0.257821 -0.417162,-2.4 0,-2.4 0.176,0 0.32,-0.206297 0.32,-0.458435 0,-0.539824 0.475155,-0.695667 2.997193,-0.983024 1.47464,-0.168019 1.911536,-0.345197 2.037325,-0.826214 0.136617,-0.522429 0.460019,-0.612327 2.202803,-0.612327 1.829344,0 2.042678,0.06684 2.042678,0.64 0,0.499642 0.213335,0.64 0.972749,0.64 0.535011,0 1.537274,0.288 2.227251,0.64 0.875949,0.446877 1.886006,0.64 3.347251,0.64 1.646886,0 2.092749,0.102266 2.092749,0.48 0,0.264 0.204224,0.48 0.453827,0.48 0.249606,0 0.67095,0.08332 0.93632,0.185149 0.348432,0.133706 0.511296,-0.06634 0.58617,-0.72 0.0984,-0.859021 0.185222,-0.905149 1.703683,-0.905149 1.507574,0 1.605849,0.05083 1.701254,0.88 0.09132,0.793696 0.224704,0.88 1.36,0.88 h 1.258746 V 45.591625 40.0119 l 1.04,-0.100275 1.039999,-0.100275 0.16,-11.36 0.16,-11.36 6.88,-0.421841 c 3.784,-0.232013 8.066586,-0.327204 9.516854,-0.211536 l 2.636855,0.210305 0.08315,14.931536 0.08315,14.931535 0.88,0.101255 c 0.827404,0.0952 0.88,0.195613 0.88,1.68 v 1.578745 h 1.422467 1.422467 l 0.09753,1.52 c 0.08176,1.274157 0.201046,1.52 0.737528,1.52 0.63022,0 0.64245,-0.266665 0.8,-17.439999 0.1533,-16.709221 0.18682,-17.485529 0.8,-18.52655 1.00678,-1.709238 2.10739,-2.315899 5.33666,-2.941595 4.529305,-0.877588 4.423345,-0.900742 4.423345,0.966581 0,1.274767 0.11805,1.615904 0.61361,1.773189 1.06528,0.338108 2.262,1.465272 2.91531,2.745875 0.59775,1.171688 0.63108,1.930436 0.63108,14.369751 v 13.132748 h 1.28 c 1.20889,0 1.28,0.05334 1.28,0.96 0,0.746666 0.14222,0.96 0.64,0.96 0.501,0 0.64,0.213335 0.64,0.982256 0,0.8356 0.1075,0.966989 0.72,0.88 0.71702,-0.101833 0.72035,-0.129734 0.80649,-6.742256 l 0.0865,-6.639999 h 2.65235 c 1.83672,0 2.84336,-0.144477 3.2735,-0.469824 0.71422,-0.540205 2.16214,-0.629911 2.9927,-0.185412 0.3132,0.167623 1.88774,0.404282 3.49896,0.525914 l 2.92951,0.221149 v 1.554086 1.554087 h 3.98068 3.98068 l 0.0993,1.2 c 0.0907,1.095545 0.18984,1.208729 1.13931,1.300275 l 1.04,0.100275 v 6.859724 6.859725 h 0.8 c 0.49778,0 0.8,0.181334 0.8,0.48 0,0.264 0.12147,0.48 0.26993,0.48 0.14846,0 0.35783,-2.75337 0.46527,-6.118598 0.10743,-3.365229 0.26175,-6.185011 0.34292,-6.266186 0.0812,-0.08117 2.40483,-0.229971 5.16368,-0.330662 3.77714,-0.137859 5.05692,-0.289472 5.18139,-0.613818 0.11025,-0.287302 0.73996,-0.430736 1.89105,-0.430736 h 1.72576 v -3.039999 -3.04 l 1.68,-0.03786 c 1.29712,-0.02925 1.46723,-0.08393 0.7464,-0.24 -1.29961,-0.281388 -1.46643,-1.00214 -0.23195,-1.00214 0.53228,0 1.05678,-0.144 1.16555,-0.32 0.32541,-0.526515 6.0419,-0.377763 8.16484,0.212464 1.97719,0.549708 2.51812,1.067536 1.11516,1.067536 -0.44,0 -0.8,0.144 -0.8,0.32 0,0.176 0.576,0.32 1.28,0.32 h 1.28 v 5.439999 5.44 h 2.5441 c 2.08537,0 2.60291,0.100976 2.87027,0.56 0.22913,0.393386 0.32907,-1.455245 0.3359,-6.213334 0.005,-3.776077 0.13881,-6.820534 0.30142,-6.88 0.16043,-0.05867 0.39614,-3.805315 0.52379,-8.325884 l 0.2321,-8.219219 1.95621,-0.201129 c 1.07592,-0.110621 3.46821,-0.155972 5.31621,-0.100781 l 3.36,0.100348 0.24404,2.4 c 0.13422,1.32 0.27822,9.168 0.32,17.44 l 0.076,15.039999 2.48,0.09346 2.48,0.09346 V 44.007666 c 0,-9.070111 0.0803,-11.110867 0.45161,-11.482211 0.35004,-0.350042 1.23165,-0.423477 3.92,-0.326523 4.40118,0.158728 4.90839,0.267093 4.90839,1.048664 0,0.579888 0.27744,0.630413 3.92,0.713904 l 3.92,0.08985 0.0872,5.821948 0.0872,5.821952 1.35285,0.09805 1.35285,0.09805 0.0883,4.88 0.0883,4.88 h 1.43167 c 1.21833,0 1.43166,0.09537 1.43166,0.64 0,0.355555 0.21334,0.64 0.48,0.64 0.26938,0 0.48,-0.28567 0.48,-0.651021 0,-0.599248 0.13361,-0.633974 1.68,-0.436649 0.924,0.117904 1.752,0.278684 1.84,0.357292 0.088,0.07861 0.232,1.676845 0.32,3.551642 l 0.16,3.40872 0.72,-0.918147 c 0.69774,-0.889754 0.72,-1.139012 0.72,-8.059949 v -7.141804 l 1.2,-0.333258 c 1.38657,-0.385069 2.58929,-0.412621 5.6,-0.128278 l 2.16,0.204 v 9.553724 c 0,7.952752 0.0747,9.553728 0.44576,9.553728 0.24518,0 0.54092,-0.247965 0.65722,-0.551031 0.18223,-0.47488 0.25666,-0.485936 0.5386,-0.08 0.24751,0.356365 0.36665,0.373655 0.48945,0.07103 0.20985,-0.517178 1.27536,-0.517178 1.61008,0 0.15144,0.233974 0.3253,-0.529744 0.41889,-1.84 l 0.16,-2.24 1.2,-0.09932 c 1.09505,-0.09063 1.2,-0.182444 1.2,-1.049846 v -0.950534 l 3.92,0.08985 3.92,0.08985 0.10126,0.88 c 0.0885,0.769478 0.23925,0.88 1.2,0.88 h 1.09874 l 0.002,2.8 c 0.001,1.54 0.0941,3.772 0.20627,4.96 l 0.20404,2.159999 H 133.65358 18.407316 Z M 215.8473,60.474206 c 0,-3.504761 -0.0778,-4.182857 -0.48,-4.182857 -0.40471,0 -0.48,0.731427 -0.48,4.662857 0,4.144762 0.0533,4.609523 0.48,4.182858 0.37771,-0.377706 0.48,-1.37143 0.48,-4.662858 z m 2.81058,-0.385984 c -0.0636,-2.516364 -0.20979,-3.624287 -0.49058,-3.717465 -0.30709,-0.10191 -0.4,0.89337 -0.4,4.285126 0,4.060589 0.0397,4.361226 0.49058,3.717466 0.385,-0.549658 0.47109,-1.47192 0.4,-4.285127 z m -93.69057,-9.876873 c 0,-5.973334 -0.11403,-9.279999 -0.32,-9.279999 -0.20598,0 -0.32,3.306665 -0.32,9.279999 0,5.973334 0.11402,9.28 0.32,9.28 0.20597,0 0.32,-3.306666 0.32,-9.28 z m 69.91999,-4.804384 c 0,-10.733881 -0.0617,-12.315615 -0.48,-12.315615 -0.41698,0 -0.491,1.631033 -0.56378,12.424191 -0.079,11.717456 -0.0517,12.418016 0.48,12.315616 0.52673,-0.101437 0.56378,-0.91799 0.56378,-12.424192 z m 15.2,3.364384 v -0.8 h -6.24 -6.24 v 0.8 0.8 h 6.24 6.24 z m -23.04,-12.639999 v -0.96 h -3.36 -3.36 v 0.96 0.96 h 3.36 3.36 z m -89.279985,-15.36 c 0.62693,-0.200779 0.45386,-0.256205 -0.8,-0.256205 -0.88,0 -1.96,0.115293 -2.4,0.256205 -0.62694,0.200779 -0.45387,0.256205 0.8,0.256205 0.88,0 1.96,-0.115292 2.4,-0.256205 z m 0.8,-1.663801 c 0.20821,-0.203112 -0.4625,-0.233977 -1.92,-0.08836 -1.232,0.12309 -2.384,0.364272 -2.56,0.535958 -0.20822,0.203112 0.46249,0.233978 1.92,0.08836 1.232,-0.123091 2.384,-0.364272 2.56,-0.535958 z m 0,-1.282313 c 0.20575,-0.19834 -0.36545,-0.227671 -1.6,-0.08216 -2.69606,0.317779 -3.41147,0.848727 -0.8,0.593725 1.144,-0.111708 2.224,-0.341914 2.4,-0.511569 z m -0.16,-1.091001 c 0.44923,-0.09145 1.10923,-0.645164 1.50526,-1.262871 0.805475,-1.256302 0.862645,-1.233053 -1.60474,-0.652498 -1.71545,0.403632 -3.42052,1.498493 -3.42052,2.196392 0,0.265328 1.37569,0.155498 3.52,-0.281023 z"
                    ]
                    []
                ]
            ]


sold =
    html <|
        Svg.svg
            [ Atr.width "100%", Atr.height "100%", Atr.viewBox "0 0 1000 1000", Atr.fill "currentColor" ]
            [ Svg.g
                [ Atr.transform "translate(0.000000,511.000000) scale(0.100000,-0.100000)" ]
                [ Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.d "M1268.7,4722.8l-350.4-296.7v-585.6v-585.6H509.2H100v-716.1v-716.1h409.2h409.2v-3299.1v-3299.1h703.3h703.3v3299.1v3299.1h843.9h843.9v-460.3V902h-422h-422v-2173.8v-2173.8h2800.4h2800.4v2173.8V902h-409.2h-409.2v460.3v460.3h672.6l670,2.6l301.8,358l304.3,358l-148.3,171.3c-79.3,94.6-217.4,255.7-301.8,358l-156,184.1H5810.7H2324.9v585.6v583.1l-312,266c-173.9,145.8-332.5,281.3-355.5,299.2C1621.7,5014.3,1565.4,4975.9,1268.7,4722.8z M7439.8,1362.3V902H5982H4524.3v460.3v460.3H5982h1457.7V1362.3z M8258.1-1271.8v-1662.3H5969.3H3680.4v1662.3V390.5h2288.9h2288.9V-1271.8z"
                    ]
                    []
                , Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.d "M4245.6-752.7c-117.6-61.4-186.7-158.5-189.2-273.6c-2.6-130.4,71.6-217.4,278.8-322.2c158.6-81.8,176.5-97.2,176.5-166.2c0-102.3-92.1-135.5-276.2-97.2c-71.6,15.3-140.7,20.5-148.3,12.8c-10.2-10.2-25.6-53.7-33.2-97.2c-17.9-76.7-15.3-81.8,97.2-110c237.8-58.8,434.8-17.9,557.5,120.2c69,81.8,76.7,102.3,63.9,220c-12.8,145.8-92.1,232.7-266,294.1c-140.7,51.1-212.3,104.8-212.3,156c0,84.4,66.5,110,240.4,94.6l163.7-15.3l15.3,79.3c7.7,46,5.1,92.1-10.2,107.4c-15.3,15.3-104.9,30.7-199.5,35.8C4376-709.2,4309.5-716.9,4245.6-752.7z"
                    ]
                    []
                , Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.d "M5242.9-737.3c-268.5-107.4-398.9-429.6-304.3-746.8c104.8-352.9,557.5-462.9,841.4-204.6c222.5,202,225.1,657.3,5.1,856.7C5664.9-724.5,5396.4-676,5242.9-737.3z M5588.2-970.1c58.8-53.7,112.5-204.6,112.5-317.1c-2.5-102.3-87-281.3-148.3-314.6c-222.5-117.7-422,99.7-381.1,411.7C5204.6-939.4,5424.5-821.7,5588.2-970.1z"
                    ]
                    []
                , Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.d "M7038.2-727.1l-84.4-10.2v-534.5v-531.9l127.9-17.9c230.2-30.7,542.2,38.4,662.4,148.3c97.2,92.1,156,243,156,422c0,255.7-81.8,391.3-294.1,480.8C7503.7-729.7,7191.7-704.1,7038.2-727.1z M7547.2-987.9c81.8-71.6,84.4-81.8,84.4-268.5c0-184.1-5.1-196.9-81.8-273.6c-66.5-69.1-104.8-84.4-222.5-94.6L7184-1635v360.6v360.6h140.7C7442.3-913.8,7478.1-924,7547.2-987.9z"
                    ]
                    []
                , Svg.path
                    [ Atr.fillRule "evenodd"
                    , Atr.clipRule "evenodd"
                    , Atr.d "M6109.9-1271.8v-537.1h345.2h345.3v102.3v102.3H6583h-217.4v434.8v434.8h-127.9h-127.9V-1271.8z"
                    ]
                    []
                ]
            ]


-- HEIGHT


hMax =
    height fill


h10 =
    basefont * 2.5 |> round |> px |> height


h11 =
    basefont * 2.75 |> round |> px |> height


h12 =
    basefont * 3 |> px |> height


h14 =
    basefont * 3.5 |> round |> px |> height


h16 =
    basefont * 4 |> round |> px |> height


h20 =
    basefont * 5 |> round |> px |> height



-- WIDTH


wMax =
    width fill


w10 =
    basefont * 2.5 |> round |> px |> width


w11 =
    basefont * 2.75 |> round |> px |> width


w12 =
    basefont * 3 |> px |> width


w14 =
    basefont * 3.5 |> round |> px |> width


w16 =
    basefont * 4 |> round |> px |> width


w20 =
    basefont * 5 |> round |> px |> width



-- PADDING


p2 =
    basefont * 0.5 |> round |> padding


p2_5 =
    basefont * 0.625 |> round |> padding


p3 =
    basefont * 0.75 |> round |> padding


p3_5 =
    basefont * 0.875 |> round |> padding


p4 =
    basefont * 1 |> round |> padding


p5 =
    basefont * 1.25 |> round |> padding


p6 =
    basefont * 1.5 |> round |> padding


p7 =
    basefont * 1.75 |> round |> padding


p8 =
    basefont * 2 |> round |> padding


p8notBottom =
    basefont * 2 |> round |> (\p -> paddingEach { top = p, bottom = 0, left = p, right = p })


p4notBottom =
    basefont * 1 |> round |> (\p -> paddingEach { top = p, bottom = 0, left = p, right = p })


p9 =
    basefont * 2.25 |> round |> padding


p10 =
    basefont * 2.5 |> round |> padding


p11 =
    basefont * 2.75 |> round |> padding


p12 =
    basefont * 3 |> round |> padding


p14 =
    basefont * 3.5 |> round |> padding


p16 =
    basefont * 4 |> round |> padding


p20 =
    basefont * 5 |> round |> padding


p24 =
    basefont * 6 |> round |> padding



-- SPACING


s1 =
    basefont * 0.25 |> round |> spacing


s2 =
    basefont * 0.5 |> round |> spacing


s2_5 =
    basefont * 0.625 |> round |> spacing


s3 =
    basefont * 0.75 |> round |> spacing


s3_5 =
    basefont * 0.875 |> round |> spacing


s4 =
    basefont * 1 |> round |> spacing


s5 =
    basefont * 1.25 |> round |> spacing


s6 =
    basefont * 1.5 |> round |> spacing


s7 =
    basefont * 1.75 |> round |> spacing


s8 =
    basefont * 2 |> round |> spacing


s9 =
    basefont * 2.25 |> round |> spacing


s10 =
    basefont * 2.5 |> round |> spacing


s11 =
    basefont * 2.75 |> round |> spacing


s12 =
    basefont * 3 |> round |> spacing


s14 =
    basefont * 3.5 |> round |> spacing


s16 =
    basefont * 4 |> round |> spacing


s20 =
    basefont * 5 |> round |> spacing


s24 =
    basefont * 6 |> round |> spacing



-- FONT SIZE
-- TODO: Tailwind also scales line spacing with these, it is not imediatly obvious
-- how to do this in elm-ui, so this just does Font.size for now, bundling spacing
-- will have to come later.
-- COLORS


ablack a =
    rgba255 0 0 0 a


black =
    rgb255 0 0 0


awhite a =
    rgba255 255 255 255 a


white =
    rgb255 255 255 255


aslate50 a =
    rgba255 248 250 252 a


slate50 =
    rgb255 248 250 252


aslate100 a =
    rgba255 241 245 249 a


slate100 =
    rgb255 241 245 249


aslate200 a =
    rgba255 226 232 240 a


slate200 =
    rgb255 226 232 240


aslate300 a =
    rgba255 203 213 225 a


slate300 =
    rgb255 203 213 225


aslate400 a =
    rgba255 148 163 184 a


slate400 =
    rgb255 148 163 184


aslate500 a =
    rgba255 100 116 139 a


slate500 =
    rgb255 100 116 139


aslate600 a =
    rgba255 71 85 105 a


slate600 =
    rgb255 71 85 105


aslate700 a =
    rgba255 51 65 85 a


slate700 =
    rgb255 51 65 85


aslate800 a =
    rgba255 30 41 59 a


slate800 =
    rgb255 30 41 59


aslate900 a =
    rgba255 15 23 42 a


slate900 =
    rgb255 15 23 42


agray50 a =
    rgba255 249 250 251 a


gray50 =
    rgb255 249 250 251


agray100 a =
    rgba255 243 244 246 a


gray100 =
    rgb255 243 244 246


agray200 a =
    rgba255 229 231 235 a


gray200 =
    rgb255 229 231 235


agray300 a =
    rgba255 209 213 219 a


gray300 =
    rgb255 209 213 219


agray400 a =
    rgba255 156 163 175 a


gray400 =
    rgb255 156 163 175


agray500 a =
    rgba255 107 114 128 a


gray500 =
    rgb255 107 114 128


agray600 a =
    rgba255 75 85 99 a


gray600 =
    rgb255 75 85 99


agray700 a =
    rgba255 55 65 81 a


gray700 =
    rgb255 55 65 81


agray800 a =
    rgba255 31 41 55 a


gray800 =
    rgb255 31 41 55


agray900 a =
    rgba255 17 24 39 a


gray900 =
    rgb255 17 24 39


azinc50 a =
    rgba255 250 250 250 a


zinc50 =
    rgb255 250 250 250


azinc100 a =
    rgba255 244 244 245 a


zinc100 =
    rgb255 244 244 245


azinc200 a =
    rgba255 228 228 231 a


zinc200 =
    rgb255 228 228 231


azinc300 a =
    rgba255 212 212 216 a


zinc300 =
    rgb255 212 212 216


azinc400 a =
    rgba255 161 161 170 a


zinc400 =
    rgb255 161 161 170


azinc500 a =
    rgba255 113 113 122 a


zinc500 =
    rgb255 113 113 122


azinc600 a =
    rgba255 82 82 91 a


zinc600 =
    rgb255 82 82 91


azinc700 a =
    rgba255 63 63 70 a


zinc700 =
    rgb255 63 63 70


azinc800 a =
    rgba255 39 39 42 a


zinc800 =
    rgb255 39 39 42


azinc900 a =
    rgba255 24 24 27 a


zinc900 =
    rgb255 24 24 27


aneutral50 a =
    rgba255 250 250 250 a


neutral50 =
    rgb255 250 250 250


aneutral100 a =
    rgba255 245 245 245 a


neutral100 =
    rgb255 245 245 245


aneutral200 a =
    rgba255 229 229 229 a


neutral200 =
    rgb255 229 229 229


aneutral300 a =
    rgba255 212 212 212 a


neutral300 =
    rgb255 212 212 212


aneutral400 a =
    rgba255 163 163 163 a


neutral400 =
    rgb255 163 163 163


aneutral500 a =
    rgba255 115 115 115 a


neutral500 =
    rgb255 115 115 115


aneutral600 a =
    rgba255 82 82 82 a


neutral600 =
    rgb255 82 82 82


aneutral700 a =
    rgba255 64 64 64 a


neutral700 =
    rgb255 64 64 64


aneutral800 a =
    rgba255 38 38 38 a


neutral800 =
    rgb255 38 38 38


aneutral900 a =
    rgba255 23 23 23 a


neutral900 =
    rgb255 23 23 23


astone50 a =
    rgba255 250 250 249 a


stone50 =
    rgb255 250 250 249


astone100 a =
    rgba255 245 245 244 a


stone100 =
    rgb255 245 245 244


astone200 a =
    rgba255 231 229 228 a


stone200 =
    rgb255 231 229 228


astone300 a =
    rgba255 214 211 209 a


stone300 =
    rgb255 214 211 209


astone400 a =
    rgba255 168 162 158 a


stone400 =
    rgb255 168 162 158


astone500 a =
    rgba255 120 113 108 a


stone500 =
    rgb255 120 113 108


astone600 a =
    rgba255 87 83 78 a


stone600 =
    rgb255 87 83 78


astone700 a =
    rgba255 68 64 60 a


stone700 =
    rgb255 68 64 60


astone800 a =
    rgba255 41 37 36 a


stone800 =
    rgb255 41 37 36


astone900 a =
    rgba255 28 25 23 a


stone900 =
    rgb255 28 25 23


ared50 a =
    rgba255 254 242 242 a


red50 =
    rgb255 254 242 242


ared100 a =
    rgba255 254 226 226 a


red100 =
    rgb255 254 226 226


ared200 a =
    rgba255 254 202 202 a


red200 =
    rgb255 254 202 202


ared300 a =
    rgba255 252 165 165 a


red300 =
    rgb255 252 165 165


ared400 a =
    rgba255 248 113 113 a


red400 =
    rgb255 248 113 113


ared500 a =
    rgba255 239 68 68 a


red500 =
    rgb255 239 68 68


ared600 a =
    rgba255 220 38 38 a


red600 =
    rgb255 220 38 38


ared700 a =
    rgba255 185 28 28 a


red700 =
    rgb255 185 28 28


ared800 a =
    rgba255 153 27 27 a


red800 =
    rgb255 153 27 27


ared900 a =
    rgba255 127 29 29 a


red900 =
    rgb255 127 29 29


aorange50 a =
    rgba255 255 247 237 a


orange50 =
    rgb255 255 247 237


aorange100 a =
    rgba255 255 237 213 a


orange100 =
    rgb255 255 237 213


aorange200 a =
    rgba255 254 215 170 a


orange200 =
    rgb255 254 215 170


aorange300 a =
    rgba255 253 186 116 a


orange300 =
    rgb255 253 186 116


aorange400 a =
    rgba255 251 146 60 a


orange400 =
    rgb255 251 146 60


aorange500 a =
    rgba255 249 115 22 a


orange500 =
    rgb255 249 115 22


aorange600 a =
    rgba255 234 88 12 a


orange600 =
    rgb255 234 88 12


aorange700 a =
    rgba255 194 65 12 a


orange700 =
    rgb255 194 65 12


aorange800 a =
    rgba255 154 52 18 a


orange800 =
    rgb255 154 52 18


aorange900 a =
    rgba255 124 45 18 a


orange900 =
    rgb255 124 45 18


aamber50 a =
    rgba255 255 251 235 a


amber50 =
    rgb255 255 251 235


aamber100 a =
    rgba255 254 243 199 a


amber100 =
    rgb255 254 243 199


aamber200 a =
    rgba255 253 230 138 a


amber200 =
    rgb255 253 230 138


aamber300 a =
    rgba255 252 211 77 a


amber300 =
    rgb255 252 211 77


aamber400 a =
    rgba255 251 191 36 a


amber400 =
    rgb255 251 191 36


aamber500 a =
    rgba255 245 158 11 a


amber500 =
    rgb255 245 158 11


aamber600 a =
    rgba255 217 119 6 a


amber600 =
    rgb255 217 119 6


aamber700 a =
    rgba255 180 83 9 a


amber700 =
    rgb255 180 83 9


aamber800 a =
    rgba255 146 64 14 a


amber800 =
    rgb255 146 64 14


aamber900 a =
    rgba255 120 53 15 a


amber900 =
    rgb255 120 53 15


ayellow50 a =
    rgba255 254 252 232 a


yellow50 =
    rgb255 254 252 232


ayellow100 a =
    rgba255 254 249 195 a


yellow100 =
    rgb255 254 249 195


ayellow200 a =
    rgba255 254 240 138 a


yellow200 =
    rgb255 254 240 138


ayellow300 a =
    rgba255 253 224 71 a


yellow300 =
    rgb255 253 224 71


ayellow400 a =
    rgba255 250 204 21 a


yellow400 =
    rgb255 250 204 21


ayellow500 a =
    rgba255 234 179 8 a


yellow500 =
    rgb255 234 179 8


ayellow600 a =
    rgba255 202 138 4 a


yellow600 =
    rgb255 202 138 4


ayellow700 a =
    rgba255 161 98 7 a


yellow700 =
    rgb255 161 98 7


ayellow800 a =
    rgba255 133 77 14 a


yellow800 =
    rgb255 133 77 14


ayellow900 a =
    rgba255 113 63 18 a


yellow900 =
    rgb255 113 63 18


alime50 a =
    rgba255 247 254 231 a


lime50 =
    rgb255 247 254 231


alime100 a =
    rgba255 236 252 203 a


lime100 =
    rgb255 236 252 203


alime200 a =
    rgba255 217 249 157 a


lime200 =
    rgb255 217 249 157


alime300 a =
    rgba255 190 242 100 a


lime300 =
    rgb255 190 242 100


alime400 a =
    rgba255 163 230 53 a


lime400 =
    rgb255 163 230 53


alime500 a =
    rgba255 132 204 22 a


lime500 =
    rgb255 132 204 22


alime600 a =
    rgba255 101 163 13 a


lime600 =
    rgb255 101 163 13


alime700 a =
    rgba255 77 124 15 a


lime700 =
    rgb255 77 124 15


alime800 a =
    rgba255 63 98 18 a


lime800 =
    rgb255 63 98 18


alime900 a =
    rgba255 54 83 20 a


lime900 =
    rgb255 54 83 20


agreen50 a =
    rgba255 240 253 244 a


green50 =
    rgb255 240 253 244


agreen100 a =
    rgba255 220 252 231 a


green100 =
    rgb255 220 252 231


agreen200 a =
    rgba255 187 247 208 a


green200 =
    rgb255 187 247 208


agreen300 a =
    rgba255 134 239 172 a


green300 =
    rgb255 134 239 172


agreen400 a =
    rgba255 74 222 128 a


green400 =
    rgb255 74 222 128


agreen500 a =
    rgba255 34 197 94 a


green500 =
    rgb255 34 197 94


agreen600 a =
    rgba255 22 163 74 a


green600 =
    rgb255 22 163 74


agreen700 a =
    rgba255 21 128 61 a


green700 =
    rgb255 21 128 61


agreen800 a =
    rgba255 22 101 52 a


green800 =
    rgb255 22 101 52


agreen900 a =
    rgba255 20 83 45 a


green900 =
    rgb255 20 83 45


aemerald50 a =
    rgba255 236 253 245 a


emerald50 =
    rgb255 236 253 245


aemerald100 a =
    rgba255 209 250 229 a


emerald100 =
    rgb255 209 250 229


aemerald200 a =
    rgba255 167 243 208 a


emerald200 =
    rgb255 167 243 208


aemerald300 a =
    rgba255 110 231 183 a


emerald300 =
    rgb255 110 231 183


aemerald400 a =
    rgba255 52 211 153 a


emerald400 =
    rgb255 52 211 153


aemerald500 a =
    rgba255 16 185 129 a


emerald500 =
    rgb255 16 185 129


aemerald600 a =
    rgba255 5 150 105 a


emerald600 =
    rgb255 5 150 105


aemerald700 a =
    rgba255 4 120 87 a


emerald700 =
    rgb255 4 120 87


aemerald800 a =
    rgba255 6 95 70 a


emerald800 =
    rgb255 6 95 70


aemerald900 a =
    rgba255 6 78 59 a


emerald900 =
    rgb255 6 78 59


ateal50 a =
    rgba255 240 253 250 a


teal50 =
    rgb255 240 253 250


ateal100 a =
    rgba255 204 251 241 a


teal100 =
    rgb255 204 251 241


ateal200 a =
    rgba255 153 246 228 a


teal200 =
    rgb255 153 246 228


ateal300 a =
    rgba255 94 234 212 a


teal300 =
    rgb255 94 234 212


ateal400 a =
    rgba255 45 212 191 a


teal400 =
    rgb255 45 212 191


ateal500 a =
    rgba255 20 184 166 a


teal500 =
    rgb255 20 184 166


ateal600 a =
    rgba255 13 148 136 a


teal600 =
    rgb255 13 148 136


ateal700 a =
    rgba255 15 118 110 a


teal700 =
    rgb255 15 118 110


ateal800 a =
    rgba255 17 94 89 a


teal800 =
    rgb255 17 94 89


ateal900 a =
    rgba255 19 78 74 a


teal900 =
    rgb255 19 78 74


acyan50 a =
    rgba255 236 254 255 a


cyan50 =
    rgb255 236 254 255


acyan100 a =
    rgba255 207 250 254 a


cyan100 =
    rgb255 207 250 254


acyan200 a =
    rgba255 165 243 252 a


cyan200 =
    rgb255 165 243 252


acyan300 a =
    rgba255 103 232 249 a


cyan300 =
    rgb255 103 232 249


acyan400 a =
    rgba255 34 211 238 a


cyan400 =
    rgb255 34 211 238


acyan500 a =
    rgba255 6 182 212 a


cyan500 =
    rgb255 6 182 212


acyan600 a =
    rgba255 8 145 178 a


cyan600 =
    rgb255 8 145 178


acyan700 a =
    rgba255 14 116 144 a


cyan700 =
    rgb255 14 116 144


acyan800 a =
    rgba255 21 94 117 a


cyan800 =
    rgb255 21 94 117


acyan900 a =
    rgba255 22 78 99 a


cyan900 =
    rgb255 22 78 99


asky50 a =
    rgba255 240 249 255 a


sky50 =
    rgb255 240 249 255


asky100 a =
    rgba255 224 242 254 a


sky100 =
    rgb255 224 242 254


asky200 a =
    rgba255 186 230 253 a


sky200 =
    rgb255 186 230 253


asky300 a =
    rgba255 125 211 252 a


sky300 =
    rgb255 125 211 252


asky400 a =
    rgba255 56 189 248 a


sky400 =
    rgb255 56 189 248


asky500 a =
    rgba255 14 165 233 a


sky500 =
    rgb255 14 165 233


asky600 a =
    rgba255 2 132 199 a


sky600 =
    rgb255 2 132 199


asky700 a =
    rgba255 3 105 161 a


sky700 =
    rgb255 3 105 161


asky800 a =
    rgba255 7 89 133 a


sky800 =
    rgb255 7 89 133


asky900 a =
    rgba255 12 74 110 a


sky900 =
    rgb255 12 74 110


ablue50 a =
    rgba255 239 246 255 a


blue50 =
    rgb255 239 246 255


ablue100 a =
    rgba255 219 234 254 a


blue100 =
    rgb255 219 234 254


ablue200 a =
    rgba255 191 219 254 a


blue200 =
    rgb255 191 219 254


ablue300 a =
    rgba255 147 197 253 a


blue300 =
    rgb255 147 197 253


ablue400 a =
    rgba255 96 165 250 a


blue400 =
    rgb255 96 165 250


ablue500 a =
    rgba255 59 130 246 a


blue500 =
    rgb255 59 130 246


ablue600 a =
    rgba255 37 99 235 a


blue600 =
    rgb255 37 99 235


ablue700 a =
    rgba255 29 78 216 a


blue700 =
    rgb255 29 78 216


ablue800 a =
    rgba255 30 64 175 a


blue800 =
    rgb255 30 64 175


ablue900 a =
    rgba255 30 58 138 a


blue900 =
    rgb255 30 58 138


aindigo50 a =
    rgba255 238 242 255 a


indigo50 =
    rgb255 238 242 255


aindigo100 a =
    rgba255 224 231 255 a


indigo100 =
    rgb255 224 231 255


aindigo200 a =
    rgba255 199 210 254 a


indigo200 =
    rgb255 199 210 254


aindigo300 a =
    rgba255 165 180 252 a


indigo300 =
    rgb255 165 180 252


aindigo400 a =
    rgba255 129 140 248 a


indigo400 =
    rgb255 129 140 248


aindigo500 a =
    rgba255 99 102 241 a


indigo500 =
    rgb255 99 102 241


aindigo600 a =
    rgba255 79 70 229 a


indigo600 =
    rgb255 79 70 229


aindigo700 a =
    rgba255 67 56 202 a


indigo700 =
    rgb255 67 56 202


aindigo800 a =
    rgba255 55 48 163 a


indigo800 =
    rgb255 55 48 163


aindigo900 a =
    rgba255 49 46 129 a


indigo900 =
    rgb255 49 46 129


aviolet50 a =
    rgba255 245 243 255 a


violet50 =
    rgb255 245 243 255


aviolet100 a =
    rgba255 237 233 254 a


violet100 =
    rgb255 237 233 254


aviolet200 a =
    rgba255 221 214 254 a


violet200 =
    rgb255 221 214 254


aviolet300 a =
    rgba255 196 181 253 a


violet300 =
    rgb255 196 181 253


aviolet400 a =
    rgba255 167 139 250 a


violet400 =
    rgb255 167 139 250


aviolet500 a =
    rgba255 139 92 246 a


violet500 =
    rgb255 139 92 246


aviolet600 a =
    rgba255 124 58 237 a


violet600 =
    rgb255 124 58 237


aviolet700 a =
    rgba255 109 40 217 a


violet700 =
    rgb255 109 40 217


aviolet800 a =
    rgba255 91 33 182 a


violet800 =
    rgb255 91 33 182


aviolet900 a =
    rgba255 76 29 149 a


violet900 =
    rgb255 76 29 149


apurple50 a =
    rgba255 250 245 255 a


purple50 =
    rgb255 250 245 255


apurple100 a =
    rgba255 243 232 255 a


purple100 =
    rgb255 243 232 255


apurple200 a =
    rgba255 233 213 255 a


purple200 =
    rgb255 233 213 255


apurple300 a =
    rgba255 216 180 254 a


purple300 =
    rgb255 216 180 254


apurple400 a =
    rgba255 192 132 252 a


purple400 =
    rgb255 192 132 252


apurple500 a =
    rgba255 168 85 247 a


purple500 =
    rgb255 168 85 247


apurple600 a =
    rgba255 147 51 234 a


purple600 =
    rgb255 147 51 234


apurple700 a =
    rgba255 126 34 206 a


purple700 =
    rgb255 126 34 206


apurple800 a =
    rgba255 107 33 168 a


purple800 =
    rgb255 107 33 168


apurple900 a =
    rgba255 88 28 135 a


purple900 =
    rgb255 88 28 135


afuchsia50 a =
    rgba255 253 244 255 a


fuchsia50 =
    rgb255 253 244 255


afuchsia100 a =
    rgba255 250 232 255 a


fuchsia100 =
    rgb255 250 232 255


afuchsia200 a =
    rgba255 245 208 254 a


fuchsia200 =
    rgb255 245 208 254


afuchsia300 a =
    rgba255 240 171 252 a


fuchsia300 =
    rgb255 240 171 252


afuchsia400 a =
    rgba255 232 121 249 a


fuchsia400 =
    rgb255 232 121 249


afuchsia500 a =
    rgba255 217 70 239 a


fuchsia500 =
    rgb255 217 70 239


afuchsia600 a =
    rgba255 192 38 211 a


fuchsia600 =
    rgb255 192 38 211


afuchsia700 a =
    rgba255 162 28 175 a


fuchsia700 =
    rgb255 162 28 175


afuchsia800 a =
    rgba255 134 25 143 a


fuchsia800 =
    rgb255 134 25 143


afuchsia900 a =
    rgba255 112 26 117 a


fuchsia900 =
    rgb255 112 26 117


apink50 a =
    rgba255 253 242 248 a


pink50 =
    rgb255 253 242 248


apink100 a =
    rgba255 252 231 243 a


pink100 =
    rgb255 252 231 243


apink200 a =
    rgba255 251 207 232 a


pink200 =
    rgb255 251 207 232


apink300 a =
    rgba255 249 168 212 a


pink300 =
    rgb255 249 168 212


apink400 a =
    rgba255 244 114 182 a


pink400 =
    rgb255 244 114 182


apink500 a =
    rgba255 236 72 153 a


pink500 =
    rgb255 236 72 153


apink600 a =
    rgba255 219 39 119 a


pink600 =
    rgb255 219 39 119


apink700 a =
    rgba255 190 24 93 a


pink700 =
    rgb255 190 24 93


apink800 a =
    rgba255 157 23 77 a


pink800 =
    rgb255 157 23 77


apink900 a =
    rgba255 131 24 67 a


pink900 =
    rgb255 131 24 67


arose50 a =
    rgba255 255 241 242 a


rose50 =
    rgb255 255 241 242


arose100 a =
    rgba255 255 228 230 a


rose100 =
    rgb255 255 228 230


arose200 a =
    rgba255 254 205 211 a


rose200 =
    rgb255 254 205 211


arose300 a =
    rgba255 253 164 175 a


rose300 =
    rgb255 253 164 175


arose400 a =
    rgba255 251 113 133 a


rose400 =
    rgb255 251 113 133


arose500 a =
    rgba255 244 63 94 a


rose500 =
    rgb255 244 63 94


arose600 a =
    rgba255 225 29 72 a


rose600 =
    rgb255 225 29 72


arose700 a =
    rgba255 190 18 60 a


rose700 =
    rgb255 190 18 60


arose800 a =
    rgba255 159 18 57 a


rose800 =
    rgb255 159 18 57


arose900 a =
    rgba255 136 19 55 a


rose900 =
    rgb255 136 19 55
