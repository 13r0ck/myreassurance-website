module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Head
import Head.Seo as Seo
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Tailwind exposing (..)
import View exposing (View)
import Wheel
import Simple.Transition as Transition
import Utils.Transition as Transition
import Element.Events as Events


type alias Model =
    { wheelPercentage : Int }


type Msg
    = WheelHover Int


type alias RouteParams =
    {}


page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildWithLocalState { view = view, init = init, update = update, subscriptions = subscriptions }


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "MyREAsurance"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel model static =
    { title = "MyREAssurance"
    , body =
        [ landingView model.wheelPercentage ]
    }

init maybeUrl sharedModel static =
    ({ wheelPercentage = 0
    }, Cmd.none)


update maybeUrl key sharedModel static msg model =
    case msg of
        WheelHover percentage ->
            ({ model | wheelPercentage = percentage }, Cmd.none)

subscriptions maybeUrl routeParams path model =
    Sub.none



-- Elm simple animation


animatedUi =
    Animated.ui
        { behindContent = Element.behindContent
        , htmlAttribute = Element.htmlAttribute
        , html = Element.html
        }


aEl : Animation -> List (Element.Attribute msg) -> Element msg -> Element msg
aEl =
    animatedUi Element.el



-- TYPES

primaryColor =
    red600


landingView wheelPercentage =
    Element.layoutWith { options = [ focusStyle (FocusStyle Nothing Nothing Nothing) ] }
        [ inFront navbar
        , width fill
        , height fill
        ]
        -- TODO make height of this variable
        (column [ width fill, s4 ]
            [ navbar
            , jumbotron
                { title = row [] [ text "MY", el [ Font.color primaryColor ] (text "REA"), text "SSURANCE" ]
                , callToAction = "Join Now"
                , image = "/img/01 Exterior Front-Edit.jpg"
                , subTitle = "Everything you want from a top real estate agent."
                , wheelPercentage = wheelPercentage
                , content =
                    [ "This offer is all about saving you money but not scarfing the top tier service you are used to from me"
                    , "This will make selling and buying real estate cheaper than any ibuyer or discount broker in the market today! You will receive the full level of service from a top tier agent, high level representation and negotiation when selling and buying and NEVER pay a listing commission, EVER!"
                    , "That’s right NEVER pay a listing commission or convivence fee to a real estate agent or ibuyer EVER again and get top dollar on the sale of your home!"
                    ]
                }
            ]
        )


navbar =
    row
        [ width fill
        , Region.navigation
        , h16
        , Background.color white
        , Border.shadow { blur = 10, color = ared100 0, offset = ( 0, 0 ), size = 0.5 }
        ]
        [ el [ p2, Font.bold ] (text "MyREAsurance") ]


-- jumbotron :
--     { title : Element msg
--     , callToAction : String
--     , image : String
--     , subTitle : String
--     , content : List String
--     , wheelPercentage : Int
--     }
--     -> Element Msg
jumbotron info =
    let
        rounding =
            10
    in
    column
        [ width fill
        , height fill
        , Font.color slate900
        , inFront
            (el
                [ height (px 500)
                , width (px 800)
                , Background.image info.image
                , centerX
                , centerY
                , Font.color white
                , moveLeft 200
                , Border.rounded rounding
                , inFront (column [ centerX, s8, p8 ] [ el [ Font.size 80, s8, Font.bold ] info.title ])
                , inFront
                    ( column
                        [ centerX, centerY, s8, p8 ]
                        [ Input.button
                            [ centerX
                            , text_3xl
                            , Font.letterSpacing (if info.wheelPercentage > 50 then 4 else 2)
                            , s8
                            , Font.light
                            , width (px 200)
                            , Events.onMouseEnter (WheelHover 100)
                            , Events.onMouseLeave (WheelHover 0)
                            , Transition.properties_
                                [ Transition.property "letter-spacing" 500 []
                                ]
                            ]
                            { onPress = Nothing, label = el [ inFront (el [ centerX, centerY, Font.bold] (text info.callToAction)) ] (Wheel.progress info.wheelPercentage) }
                        ]
                    )
                ]
                ( el
                    [ width fill
                    , height fill
                    , Border.rounded rounding
                    , Background.gradient
                        { angle = 135 |> degrees
                        , steps = [ ablue800 0.5, agreen800 0.5, ayellow800 0.5 ]
                        }
                    ]
                    none
                )
            )
        , inFront
            (el
                [ width (px 700)
                , Background.color (aslate100 0.8)
                , centerX
                , centerY
                , Border.rounded rounding
                , moveRight 300
                , moveDown 100
                ]
                (column [ p8, s8 ]
                    [ paragraph [ Font.bold, text_5xl ] [ text info.subTitle ]
                    , column [ text_2xl, s3 ] (List.map (\t -> paragraph [] [ text t ]) info.content)
                    ]
                )
            )
        ]
        []
