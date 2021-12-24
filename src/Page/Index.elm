module Page.Index exposing (Data, Model, Msg, page)

import Browser.Events
import DataSource exposing (DataSource)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Head
import Head.Seo as Seo
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Palette exposing (isPhone, isTabletOrSmaller)
import Shared
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Simple.Transition as Transition
import Tailwind exposing (..)
import Utils.Transition as Transition
import View exposing (View)
import Wheel


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
        , description = "Never pay a listing commission or an ibuyer convivence fee. First ever subscription based real estate service!"
        , locale = Nothing
        , title = "MyREassurance" -- metadata.title -- TODO
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
        [ landingView sharedModel model ]
    }


init maybeUrl sharedModel static =
    ( { wheelPercentage = 0 }, Cmd.none )


update maybeUrl key sharedModel static msg model =
    case msg of
        WheelHover percentage ->
            ( { model | wheelPercentage = percentage }, Cmd.none )


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
    green600


maxWidth =
    2000


landingView sharedModel model =
    let
        viewportWidth =
            sharedModel.viewportWidth

        viewportHeight =
            sharedModel.viewportHeight

        device =
            sharedModel.device

        wheelPercentage =
            model.wheelPercentage
    in
    Element.layoutWith
        { options =
            [ focusStyle (FocusStyle Nothing Nothing Nothing) ]
                ++ (if isPhone device then
                        [ forceHover ]

                    else
                        []
                   )
        }
        [ inFront navbar
        , width fill
        , height fill
        , clip
        ]
        -- TODO make height of this variable
        (column
            [ width fill
            , Font.color slate900
            ]
            [ if isPhone sharedModel.device then
                none

              else
                navbar
            , jumbotron
                { title = row [] [ text "My", el [ Font.color primaryColor ] (text "RE"), text "assurance" ]
                , callToAction = "Join Now"
                , image = "/img/house.jpg"
                , footerImage = skyline
                , subTitle = "Everything you want from a top real estate agent."
                , wheelPercentage = wheelPercentage
                , content =
                    [ "Save money and recive top tier service!"
                    , "Cheaper than any ibuyer or discount broker in the market today! Never pay a listing commision EVER!"
                    ]
                , viewportWidth = viewportWidth
                , viewportHeight = viewportHeight
                , device = device
                }
            , talkingPoints
                { titleLeft = True
                , primaryColor = primaryColor
                , secondaryColor = white
                , bottomImage = Just sold
                , title = "Never pay a listing commission or an ibuyer convivence fee."
                , callToAction =
                    { image = "/img/right.svg"
                    , description = "arrow"
                    , text = "GET STARTED"
                    }
                , points =
                    [ { title = "First ever subscription based real estate service!"
                      , content =
                            [ "Sign up today and you can sell your fist property in as little as six months."
                            , "Your subscription entitles you to two commission free sales in five years."
                            ]
                      }
                    , { title = "We are revolutionizing real estate."
                      , content =
                            [ "Low monthly subscription fee of only $49 a month and a one-time activation fee of $99."
                            , "Two commission free sales is an estimated minimum savings of $20,000!"
                            , "Potentially much more depending on the sales price of your home!"
                            ]
                      }
                    ]
                , viewportWidth = viewportWidth
                , viewportHeight = viewportHeight
                , device = device
                }
            , talkingPoints
                { titleLeft = False
                , primaryColor = white
                , secondaryColor = primaryColor
                , bottomImage = Nothing
                , title = "Never pay a listing commission or an ibuyer convivence fee."
                , callToAction =
                    { image = "/img/right.svg"
                    , description = "arrow"
                    , text = "GET STARTED"
                    }
                , points =
                    [ { title = "First ever subscription based real estate service!"
                      , content =
                            [ "Sign up today and you can sell your fist property in as little as six months."
                            , "Your subscription entitles you to two commission free sales in five years."
                            ]
                      }
                    , { title = "We are revolutionizing real estate."
                      , content =
                            [ "Low monthly subscription fee of only $49 a month and a one-time activation fee of $99."
                            , "Two commission free sales is an estimated minimum savings of $20,000!"
                            , "Potentially much more depending on the sales price of your home!"
                            ]
                      }
                    ]
                , viewportWidth = viewportWidth
                , viewportHeight = viewportHeight
                , device = device
                }
            , footer
                { backgroundColor = neutral600
                , copyright = "© " ++ String.fromInt sharedModel.currentYear ++ " MyREassurance"
                }
            ]
        )


navbar =
    row
        [ width fill
        , Region.navigation
        , h16
        ]
        []


jumbotron info =
    let
        rounding =
            10

        text_xs =
            Palette.text_xs info.device

        text_sm =
            Palette.text_sm info.device

        text_md =
            Palette.text_md info.device

        text_lg =
            Palette.text_lg info.device

        text_xl =
            Palette.text_xl info.device

        text_2xl =
            Palette.text_2xl info.device

        pad =
            if isPhone info.device then
                p2

            else
                p8

        space =
            if isPhone info.device then
                s4

            else
                s8
    in
    column
        [ width (fill |> maximum 1200)
        , centerX
        , height (px info.viewportHeight |> maximum 1200 |> minimum 900)
        , inFront
            (el
                [ height (px 500)
                , width (fill |> maximum 800)
                , Background.image info.image
                , Font.color white
                , if isTabletOrSmaller info.device then
                    centerX

                  else
                    alignLeft
                , Border.rounded
                    (if isPhone info.device then
                        0

                     else
                        rounding
                    )
                , inFront (column [ centerX, s8, p8 ] [ el [ text_2xl, s8, Font.bold ] info.title ])
                , inFront
                    (column
                        [ centerX, centerY, s8, p8 ]
                        [ Input.button
                            [ centerX
                            , text_md
                            , Font.letterSpacing
                                (if info.wheelPercentage > 50 then
                                    4

                                 else
                                    2
                                )
                            , s8
                            , Font.light
                            , width (px 200)
                            , Events.onMouseEnter (WheelHover 100)
                            , Events.onMouseLeave (WheelHover 0)
                            , Transition.properties_
                                [ Transition.property "letter-spacing" 500 []
                                ]
                            ]
                            { onPress = Nothing, label = el [ inFront (el [ centerX, centerY, Font.bold ] (text info.callToAction)) ] (Wheel.progress info.wheelPercentage primaryColor) }
                        ]
                    )
                ]
                (el
                    [ width fill
                    , height fill
                    , Border.rounded
                        (if isPhone info.device then
                            0

                         else
                            rounding
                        )
                    , Background.gradient
                        { angle = 135 |> degrees
                        , steps = [ ablue800 0.8, agreen800 0.5, ayellow800 0.5 ]
                        }
                    ]
                    none
                )
            )
        , inFront
            (el
                [ width (maximum 700 (toFloat info.viewportWidth * 0.9 |> round |> px))
                , Background.color (aslate100 0.8)
                , centerY
                , pad
                , Border.rounded rounding
                , if isTabletOrSmaller info.device then
                    centerX

                  else
                    alignRight
                , if isTabletOrSmaller info.device then
                    Font.center

                  else
                    Font.alignLeft
                , moveDown
                    (if isTabletOrSmaller info.device then
                        150

                     else
                        0
                    )
                ]
                (column [ p8, s8 ]
                    [ paragraph [ Font.bold, text_lg ] [ text info.subTitle ]
                    , column [ text_md, s3 ] (List.map (\t -> paragraph [] [ text t ]) info.content)
                    ]
                )
            )
        ]
        [ el [ width (px maxWidth), alignBottom, centerX, Font.color primaryColor, moveDown 1 ] skyline
        ]


talkingPoints info =
    let
        pointMax =
            500

        point content =
            column [ s3 ]
                [ paragraph [ text_lg, Font.bold ] [ text content.title ]
                , column [ text_md, s2 ] (List.map (\t -> paragraph [] [ text t ]) content.content)
                ]

        pad =
            if isPhone info.device then
                p4

            else
                p8

        padNotBottom =
            if isPhone info.device then
                p4notBottom

            else
                p8notBottom

        space =
            if isPhone info.device then
                s4

            else
                s8

        text_xs =
            Palette.text_xs info.device

        text_sm =
            Palette.text_sm info.device

        text_md =
            Palette.text_md info.device

        text_lg =
            Palette.text_lg info.device

        text_xl =
            Palette.text_xl info.device

        text_2xl =
            Palette.text_2xl info.device

        device =
            info.device
    in
    column
        [ width fill
        , Font.color info.secondaryColor
        ]
        [ (if isTabletOrSmaller device then
            column

           else
            row
          )
            [ centerX, width fill, Background.color info.primaryColor, p8notBottom, space ]
            ((if info.titleLeft || isTabletOrSmaller device then
                List.map (\l -> l)

              else
                List.reverse
             )
                [ column [ p8notBottom, space, width (fill |> maximum pointMax), alignTop, centerX, height fill ]
                    [ paragraph [ Font.bold, text_xl ] [ text info.title ]
                    , Input.button [ alignTop ]
                        { onPress = Nothing
                        , label =
                            el
                                [ Font.color info.secondaryColor
                                , Background.color info.primaryColor
                                , Border.rounded 50
                                , Border.width 1
                                , Transition.properties_
                                    [ Transition.property "background-color" 500 []
                                    , Transition.color 500 []
                                    ]
                                , mouseOver
                                    [ Background.color info.secondaryColor
                                    , Font.color info.primaryColor
                                    , Border.color info.secondaryColor
                                    ]
                                , p5
                                ]
                                (row
                                    [ paddingXY 20 0
                                    , centerX
                                    , Font.family [ Font.monospace ]
                                    , s4
                                    ]
                                    [ text info.callToAction.text
                                    , el [ width (px 25) ] rightArrow
                                    ]
                                )
                        }
                    , case info.bottomImage of
                        Just img ->
                            if not (isTabletOrSmaller device) then
                                el [ height (px 300), centerX, moveDown 5 ] img

                            else
                                none

                        Nothing ->
                            none
                    ]
                , column [ p8, s16, centerX, width (fill |> maximum pointMax) ] (List.map point info.points)
                , case info.bottomImage of
                    Just img ->
                        if isTabletOrSmaller device then
                            el [ height (px 300), centerX, moveDown 5 ] img

                        else
                            none

                    Nothing ->
                        none
                ]
            )
        ]


footer info =
    el [ width fill, Background.color info.backgroundColor, Font.color white, p4 ]
        (el [ width (fill |> maximum maxWidth), centerX ] (text info.copyright))
