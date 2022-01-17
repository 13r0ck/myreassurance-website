-- tailwind aliases for elm-ui


module Tailwind exposing (..)

import Element exposing (..)
import Element.Font as Font
import Html
import Html.Attributes as Attributes

-- Other


basefont =
    16


br =
    html <| Html.br [] []


style s v =
    htmlAttribute <| Attributes.style s v

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
