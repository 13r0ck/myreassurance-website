module Page.SPLAT__ exposing (Data, Model, Msg, page)

import Agreement exposing (agreement)
import Browser.Events
import Browser.Navigation as Navigation
import Char exposing (isDigit)
import DataSource exposing (DataSource)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font exposing (center)
import Element.Input as Input
import Element.Lazy as Lazy
import Element.Region as Region
import Head
import Head.Seo as Seo
import Html exposing (br, div, i, iframe)
import Html.Attributes as Atr exposing (attribute, class, id, property, src)
import Json.Encode as Encode
import Mailcheck
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import MimeType exposing (..)
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Palette exposing (isPhone, isTabletOrSmaller, text_sm)
import Path
import Ports
import Process
import Shared
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Simple.Animation.Property as Property
import Simple.Transition as Transition
import Svgs exposing (..)
import Tailwind exposing (..)
import Task
import Utils.HttpRequests as HttpRequests
import Utils.Transition as Transition
import View exposing (View)
import Wheel exposing (to255)


setupUrl =
    "http://127.0.0.1:8787/stripe/setup"


activationUrl =
    "http://127.0.0.1:8787/stripe/activation"


type alias Model =
    { wheelPercentage : Int
    , signupView : State
    , termsAccepted : Bool
    , signupPageTracker : SignUpPage
    , lockScroll : Bool
    , suggestedEmail : Maybe ( String, String, String )
    , currentAccountTab : CurrentAccountTab
    , animateSignUpView : Bool
    }


type SignUpPage
    = PrimerOne
    | Terms
    | PrimerTwo
    | PrimerThree
    | PrimerDone
    | PrimerWarning
    | ContactInfo


type State
    = Open
    | Closed


type CurrentAccountTab
    = CreateAccount
    | Login


type Msg
    = WheelHover Int
    | OpenSignUpView
    | OpenContactUs
    | CloseSignUpView
    | UpdateTerms Bool
    | Back
    | LockScroll ()
    | NextSignUpView


type alias RouteParams =
    { splat : List String }


page =
    Page.prerender
        { head = head
        , routes =
            DataSource.succeed
                [ { splat = [] }
                , { splat = [ "setup-success" ] }
                , { splat = [ "activation-success" ] }
                , { splat = [ "activation-canceled" ] }
                ]
        , data = \_ -> data
        }
        |> Page.buildWithLocalState { view = view, init = init, update = update, subscriptions = subscriptions }


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summaryLarge
        { canonicalUrlOverride = Just "MyREassurance.com"
        , siteName = "MyREAsurance"
        , image =
            { url = Pages.Url.external "https://myreassurance.com/img/seoimage.jpg"
            , alt = "A happy client's sold home."
            , dimensions = Just { height = 500, width = 800 }
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
    let
        pathRelativeValues =
            Maybe.withDefault { signupPageTracker = PrimerOne, signupView = Closed, animateSignUpView = True }
                (Maybe.map
                    (\url ->
                        case Path.toRelative url.path of
                            "setup-success" ->
                                { signupPageTracker = PrimerThree, signupView = Open, animateSignUpView = False }

                            "activation-success" ->
                                { signupPageTracker = PrimerOne, signupView = Open, animateSignUpView = False }

                            "activation-cancel" ->
                                { signupPageTracker = PrimerWarning, signupView = Open, animateSignUpView = False }

                            _ ->
                                { signupPageTracker = PrimerOne, signupView = Closed, animateSignUpView = True }
                    )
                    maybeUrl
                )
    in
    ( { wheelPercentage = 0
      , signupView = pathRelativeValues.signupView
      , termsAccepted = False
      , signupPageTracker = pathRelativeValues.signupPageTracker
      , lockScroll = False
      , suggestedEmail = Nothing
      , currentAccountTab = CreateAccount
      , animateSignUpView = pathRelativeValues.animateSignUpView
      }
    , Cmd.none
    )


update maybeUrl key sharedModel static msg model =
    let
        close =
            ( { model | signupView = Closed, signupPageTracker = PrimerOne, lockScroll = False, termsAccepted = False, animateSignUpView = True }, Cmd.none )
    in
    case msg of
        WheelHover percentage ->
            ( { model | wheelPercentage = percentage }, Cmd.none )

        UpdateTerms bool ->
            ( { model | termsAccepted = bool }, Cmd.none )

        OpenSignUpView ->
            ( { model | signupView = Open }
            , Task.perform LockScroll
                (Process.sleep
                    (if model.animateSignUpView then
                        500

                     else
                        0
                    )
                )
            )

        OpenContactUs ->
            ( { model | signupView = Open, signupPageTracker = ContactInfo }, Task.perform LockScroll (Process.sleep 500) )

        CloseSignUpView ->
            close

        Back ->
            case model.signupPageTracker of
                PrimerOne ->
                    close

                ContactInfo ->
                    close

                Terms ->
                    ( { model | termsAccepted = False, signupPageTracker = PrimerOne }, Cmd.none )

                PrimerTwo ->
                    ( { model | termsAccepted = False, signupPageTracker = Terms }, Cmd.none )

                PrimerThree ->
                    ( { model | signupPageTracker = PrimerTwo }, Cmd.none )

                PrimerDone ->
                    close

                PrimerWarning ->
                    ( { model | signupPageTracker = PrimerWarning }, Cmd.none )

        LockScroll _ ->
            ( { model | lockScroll = True }, Cmd.none )

        NextSignUpView ->
            case model.signupPageTracker of
                PrimerOne ->
                    ( { model | signupPageTracker = Terms }, Cmd.none )

                PrimerTwo ->
                    ( model, Navigation.load setupUrl )

                PrimerThree ->
                    ( model, Navigation.load activationUrl )

                ContactInfo ->
                    ( { model | signupPageTracker = ContactInfo }, Cmd.none )

                Terms ->
                    ( { model | signupPageTracker = PrimerTwo }, Cmd.none )

                PrimerDone ->
                    close

                PrimerWarning ->
                    ( { model | signupPageTracker = PrimerThree }, Cmd.none )


subscriptions maybeUrl routeParams path model =
    Sub.none



-- Elm simple animation


animatedUi =
    Animated.ui
        { behindContent = Element.behindContent
        , htmlAttribute = Element.htmlAttribute
        , html = Element.html
        }


aCol : Animation -> List (Element.Attribute msg) -> List (Element msg) -> Element msg
aCol =
    animatedUi column



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

        defaultFocusStyle =
            focusStyle (FocusStyle Nothing Nothing Nothing)

        defaultLayout =
            [ width fill, height fill, clip ]

        defaultColLayout =
            [ width fill, Font.color slate900 ]

        logo =
            row [] [ text "My", el [ Font.color primaryColor ] (text "RE"), text "assurance" ]

        spacer =
            el [ p16 ] none

        bottomText =
            { title = "Membership and services are only being offered to the first 100 of our select clientele to sign up."
            , content = [ "Don’t miss you chance to be among the first to claim your spot for this amazing cost savings opportunity and sign up TODAY!" ]
            }

        secondSectionPoints =
            [ { title = "Transfer your subscription to anyone at anytime for free!"
              , content =
                    [ "Use one sale and transfer the last sale for use by a friend or family member, or transfer both sales." ]
              }
            , { title = "The lowest cost way to sell real estate on the market today!"
              , content =
                    [ "Only $99 to start and sell two properties within two years."
                    , "No limit on the sales price of your home."
                    ]
              }
            ]

        footerArgs =
            { backgroundColor = neutral600
            , copyright = "© " ++ String.fromInt sharedModel.currentYear ++ " MyREassurance"
            , downloadText = "Transfer Your Service Here"
            , downloadLink = "/Notice of Transfer 01-03-2022.docx"
            , device = sharedModel.device
            , contactText = "Contact Us"
            , onContactClick = OpenContactUs
            , tracker = model.signupPageTracker
            }
    in
    Element.layoutWith
        { options =
            if isPhone device then
                [ defaultFocusStyle, forceHover ]

            else
                [ defaultFocusStyle ]
        }
        (case model.signupView of
            Open ->
                inFront (Lazy.lazy3 signupView sharedModel model { logo = logo, footerArgs = footerArgs, primaryColor = white, secondaryColor = primaryColor, currentAccountTab = model.currentAccountTab }) :: defaultLayout

            Closed ->
                defaultLayout
        )
        (column
            (if model.lockScroll then
                defaultColLayout ++ [ height (px sharedModel.viewportHeight), clip ]

             else
                defaultColLayout
            )
            [ if isPhone sharedModel.device then
                none

              else
                navbar
            , jumbotron
                { title = logo
                , callToAction = "Join Now"
                , image = "/img/house.jpg"
                , footerImages = [ skylineFront, skylineMiddle, skylineBack ]
                , subTitle = "Everything you want from a top real estate agent."
                , wheelPercentage = wheelPercentage
                , content =
                    [ "Save money and recive top tier service!"
                    , "Cheaper than any ibuyer or discount broker in the market today! Never pay a listing commision EVER!"
                    , "Membership and services are only being offered to the first 100 of our select clientele to sign up. Don’t miss you chance to be among the first to claim your spot for this amazing cost savings opportunity and sign up TODAY!"
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
                , bottomText = Nothing
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
            , video
                { url = "https://player.vimeo.com/video/646433917?h=3bc158f046"
                , viewportWidth = toFloat sharedModel.viewportWidth
                , device = sharedModel.device
                }
            , talkingPoints
                { titleLeft = False
                , primaryColor = white
                , secondaryColor = primaryColor
                , bottomImage = Nothing
                , bottomText = Just bottomText
                , title = "No listing commissions, ibuyer fees or transfer fees!"
                , callToAction =
                    { image = "/img/right.svg"
                    , description = "arrow"
                    , text = "GET STARTED"
                    }
                , points =
                    if isTabletOrSmaller device then
                        bottomText :: secondSectionPoints

                    else
                        secondSectionPoints
                , viewportWidth = viewportWidth
                , viewportHeight = viewportHeight
                , device = device
                }
            , spacer
            , footer
                footerArgs
            ]
        )


signupView sharedModel model info =
    aCol
        (Animation.fromTo
            { duration =
                if model.animateSignUpView then
                    500

                else
                    0
            , options = []
            }
            [ Property.opacity 0 ]
            [ Property.opacity 1 ]
        )
        [ width fill
        , height fill
        , centerX
        , Background.color slate100
        , Font.color slate900
        , scrollbarY
        ]
        [ signupNavbar
            { logo = info.logo
            , device = sharedModel.device
            }
        , column [ centerX, p8, s8 ]
            [ signUpTitle
                { title = "Create Your Account"
                , subTitle = "Be one of the first 100 to sign up!"
                , tracker = model.signupPageTracker
                , device = sharedModel.device
                }
            , signupScroller
                { suggestedEmail = model.suggestedEmail
                , signupPageTracker = model.signupPageTracker
                , fullDate = sharedModel.fullDate
                , device = sharedModel.device
                , contactPhotoUrl = "/img/contactPhoto.png"
                , contactPhotoAlt = "Zach Zaleski"
                , email = "Zach@TheRightPriceGroup.com"
                , emailIcon = emailSvg
                , name = "Zach Zaleski"
                , nameIcon = user
                , phone = "(720) 210 - 3668"
                , phoneIcon = phoneSvg
                , primaryColor = info.primaryColor
                , secondaryColor = info.secondaryColor
                , loginTabText = "Login"
                , createTabText = "Create Account"
                , manageAccountText = "Manage Account"
                , cancelText = "Cancel Subscription"
                , subscribeHeader = "Top real estate service from"
                , priceText = "for $50"
                , currentAccountTab = info.currentAccountTab
                , logo = info.logo
                , primerContent =
                    [ { header = "Three Steps To Sign Up!", message = "Accept Terms and Conditions." }
                    , { header = "Almost There!", message = "One time $99 setup." }
                    , { header = "One More Time!", message = "Activate $50/mo subscription." }
                    ]
                }
            , nextButton
                { primaryColor = info.primaryColor
                , secondaryColor = info.secondaryColor
                , signupPageTracker = model.signupPageTracker
                , device = sharedModel.device
                , termsAccepted = model.termsAccepted
                , suggestedEmail = model.suggestedEmail
                , currentAccountTab = model.currentAccountTab
                }
            ]
        , el [ alignBottom, width fill ] (footer info.footerArgs)
        ]


signupNavbar info =
    let
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
    in
    Input.button [ width fill ] { onPress = Just CloseSignUpView, label = el [ width fill, Background.color white, p8, text_md, Font.bold ] info.logo }


signUpTitle info =
    let
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
    in
    case info.tracker of
        ContactInfo ->
            none

        _ ->
            column [ centerX, s4 ]
                [ paragraph [ Font.center, Font.extraBold, text_xl ] [ text info.title ]
                , el [ centerX ] (paragraph [] [ text info.subTitle ])
                ]


signupScroller info =
    let
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
                p6

            else
                p16

        padnotTop =
            if isPhone info.device then
                p6notTop

            else
                p16notTop

        frame =
            column
                [ Background.color white
                , pad
                , s8
                , centerX
                , width (fill |> maximum 800)
                , Font.color slate700
                , Border.rounded 20
                , Border.shadow { offset = ( 5, 10 ), size = 5, blur = 20, color = slate300 }
                ]

        -- bool : b | true = left, false = right
        cornerRadius b =
            if b then
                { topLeft = 20, topRight = 0, bottomLeft = 0, bottomRight = 0 }

            else
                { topLeft = 0, bottomLeft = 0, bottomRight = 0, topRight = 20 }

        shadowOffset b =
            if b then
                ( -5, -5 )

            else
                ( 5, -5 )

        display b =
            htmlAttribute <|
                Atr.style "display"
                    (if b then
                        "none"

                     else
                        "inherit"
                    )

        isLogin =
            case info.currentAccountTab of
                CreateAccount ->
                    False

                Login ->
                    True

        passiveTab msg txt b =
            Input.button
                [ width fill
                , height (px 70)
                , Background.color info.secondaryColor
                , Font.color info.primaryColor
                , Border.roundEach (cornerRadius b)
                , Font.bold
                , Border.innerShadow { offset = shadowOffset b, size = 3, blur = 10, color = aslate700 0.2 }
                ]
                { onPress = msg
                , label = el [ centerY, centerX ] (text txt)
                }

        activeTab txt =
            el [ width fill, Font.bold, centerX, centerY, Font.color info.secondaryColor, height (px 70) ] (el [ centerX, centerY ] (text txt))

        icon =
            [ width (px 40), Font.color primaryColor ]

        displayPrimer contentList index =
            List.foldr
                (\( i, step ) merge ->
                    if i == index then
                        { merge | header = step.header, messages = step.message :: merge.messages }

                    else
                        { merge | messages = step.message :: merge.messages }
                )
                { header = "", messages = [] }
                (List.indexedMap (\i content -> ( i, content )) contentList)
                |> (\mergedPrimers ->
                        [ el [ centerX, text_md, Font.color info.secondaryColor, Font.bold ] (text mergedPrimers.header)
                        , (if isTabletOrSmaller info.device then
                            column

                           else
                            row
                          )
                            [ s16, centerX ]
                            (List.indexedMap (\i message -> primer index i message) mergedPrimers.messages)
                        ]
                   )

        primer index i message =
            column [ width fill, s4, alignTop ]
                [ el
                    [ p8
                    , Border.color info.secondaryColor
                    , Border.width 4
                    , Border.rounded 50
                    , if i > index then
                        Border.dashed

                      else
                        Border.solid
                    , if i < index then
                        Background.color info.secondaryColor

                      else
                        Font.color info.secondaryColor
                    , if i < index then
                        Font.color info.primaryColor

                      else
                        Font.color info.secondaryColor
                    , centerX
                    , inFront (el [ centerX, centerY, Font.bold, text_md, Font.family [ Font.monospace ] ] (String.fromInt (i + 1) |> text))
                    ]
                    none
                , paragraph [ Font.center ] [ text message ]
                ]
    in
    frame
        (case info.signupPageTracker of
            PrimerOne ->
                displayPrimer info.primerContent 0

            PrimerTwo ->
                displayPrimer info.primerContent 1

            PrimerThree ->
                displayPrimer info.primerContent 2

            PrimerDone ->
                [ el [ Font.bold, Font.color info.secondaryColor, centerX ] (text "Account Created!")
                , paragraph [ centerX, Font.center ] [ text "Welcome to Myreassurance! When you are ready, contact us to get everything you want from a top real estate agent." ]
                ]

            PrimerWarning ->
                [ el [ Font.bold, Font.color red500, centerX, text_lg ] (text "Account Not Created!")
                , paragraph [ centerX, Font.center ] [ text "Setup requires two charges. Please continue finish signing up!" ]
                ]

            Terms ->
                case markdownView Agreement.agreement of
                    Ok rendered ->
                        rendered

                    Err errors ->
                        [ column [ Font.center, s8, centerX, Font.color red500 ] [ el [ centerX ] (text "View failed. Please contact website administrator."), el [ centerX ] (text errors) ] ]

            ContactInfo ->
                [ column [ width fill, s16 ]
                    [ el [ Border.width 8, Border.color primaryColor, width (px 200), height (px 200), Border.rounded 1000, clip, centerX ]
                        (image
                            [ width fill, height fill ]
                            { src = info.contactPhotoUrl
                            , description = info.contactPhotoAlt
                            }
                        )
                    , column [ centerX, s8, text_sm ]
                        [ row [ s4 ] [ el icon info.nameIcon, text info.name ]
                        , link [] { url = "mailto:" ++ info.email, label = row [ s4 ] [ el icon info.emailIcon, text info.email ] }
                        , link [] { url = "tele:" ++ info.phone, label = row [ s4 ] [ el icon info.phoneIcon, text info.phone ] }
                        ]
                    ]
                ]
        )


nextButton info =
    let
        text_xs =
            Palette.text_xs info.device

        text_sm =
            Palette.text_sm info.device

        text_md =
            Palette.text_md info.device

        consentButtonText =
            "CONTINUE"

        consentText =
            "Accept Services Subscription Terms and Conditions above."

        button buttonText mainColor secondaryColor action =
            let
                defaultStyleing =
                    [ Font.color secondaryColor
                    , Background.color mainColor
                    , Border.rounded 50
                    , p5
                    , Transition.properties_
                        [ Transition.transform 500 []
                        , Transition.color 500 []
                        , Transition.backgroundColor 500 []
                        , Transition.property "box-shadow" 500 []
                        ]
                    ]

                mouseHover =
                    [ mouseOver
                        [ scale 1.05
                        ]
                    , Border.shadow { offset = ( 5, 10 ), size = 5, blur = 10, color = slate300 }
                    ]
            in
            Input.button [ alignTop, centerX ]
                { onPress = action
                , label =
                    el
                        (case action of
                            Just _ ->
                                mouseHover ++ defaultStyleing

                            Nothing ->
                                defaultStyleing
                        )
                        (row
                            [ paddingXY 30 0
                            , centerX
                            , Font.family [ Font.monospace ]
                            , s4
                            ]
                            [ text buttonText
                            ]
                        )
                }

        activeButton text =
            button text info.secondaryColor info.primaryColor (Just NextSignUpView)

        disabledButton text =
            button text slate300 slate500 Nothing

        backButton text =
            button text info.primaryColor info.secondaryColor (Just Back)

        buttonRow continueButton =
            (if isPhone info.device then
                column

             else
                row
            )
                [ s8, centerX ]
                (backButton "Back" :: continueButton)
    in
    column [ centerX, p8, width (fill |> maximum 450), s8 ]
        (case info.signupPageTracker of
            Terms ->
                let
                    enabledShadow =
                        { offset = ( 5, 10 ), size = 5, blur = 10, color = slate300 }

                    disabledShadow =
                        { offset = ( 0, 0 ), size = 0, blur = 0, color = slate300 }
                in
                [ Input.checkbox [ height fill ]
                    { checked = info.termsAccepted
                    , icon =
                        \b ->
                            el
                                [ width (px 50)
                                , centerY
                                , Font.color
                                    (if b then
                                        info.secondaryColor

                                     else
                                        slate500
                                    )
                                , Border.shadow
                                    (if b then
                                        enabledShadow

                                     else
                                        disabledShadow
                                    )
                                , Border.width 0
                                , Border.rounded 1000
                                , Transition.properties_
                                    [ Transition.transform 500 []
                                    , Transition.color 500 []
                                    , Transition.backgroundColor 500 []
                                    , Transition.property "box-shadow" 500 []
                                    ]
                                ]
                                (if b then
                                    checked

                                 else
                                    unchecked
                                )
                    , label = Input.labelRight [ width fill ] (paragraph [ Font.center, Font.color slate500, text_xs ] [ text consentText ])
                    , onChange = UpdateTerms
                    }
                , buttonRow
                    [ if info.termsAccepted then
                        activeButton consentButtonText

                      else
                        disabledButton consentButtonText
                    ]
                ]

            ContactInfo ->
                [ buttonRow [] ]

            PrimerOne ->
                [ buttonRow [ activeButton "Continue" ] ]

            PrimerTwo ->
                [ buttonRow [ activeButton "Continue" ] ]

            PrimerThree ->
                [ buttonRow [ activeButton "Continue" ] ]

            PrimerDone ->
                [ buttonRow [] ]

            PrimerWarning ->
                [ buttonRow [ activeButton "Continue" ] ]
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
                p3

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
        , height
            (px info.viewportHeight
                |> minimum
                    (if isPhone info.device then
                        1200

                     else
                        1000
                    )
            )
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
                            { onPress = Just OpenSignUpView, label = el [ inFront (el [ centerX, centerY, Font.bold ] (text info.callToAction)) ] (Wheel.progress info.wheelPercentage primaryColor) }
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
                (column [ pad, s8 ]
                    [ paragraph [ Font.bold, text_lg ] [ text info.subTitle ]
                    , column [ text_md, s6 ] (List.map (\t -> paragraph [] [ text t ]) info.content)
                    ]
                )
            )
        ]
        [ el [ width (px info.viewportWidth |> minimum 800), alignBottom, centerX, Font.color primaryColor, moveDown 1 ] (stackImages none info.footerImages primaryColor)
        ]


talkingPoints info =
    let
        pointMax =
            500

        point content =
            (case info.bottomText of
                Just _ ->
                    if isTabletOrSmaller device then
                        column [ s3 ]

                    else
                        column [ s3, height (px 350) ]

                Nothing ->
                    column [ s3 ]
            )
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
                [ column [ p8notBottom, s16, width (fill |> maximum pointMax), alignTop, centerX, height fill ]
                    [ column
                        [ height
                            (if isTabletOrSmaller device then
                                fill

                             else
                                px 350
                            )
                        , space
                        ]
                        [ paragraph [ Font.bold, text_xl ] [ text info.title ]
                        , Input.button [ alignTop ]
                            { onPress = Just OpenSignUpView
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
                        ]
                    , case info.bottomImage of
                        Just img ->
                            if not (isTabletOrSmaller device) then
                                el [ height (px 300), centerX, moveDown 5, alignBottom ] img

                            else
                                none

                        Nothing ->
                            none
                    , case info.bottomText of
                        Just bottomText ->
                            if not (isTabletOrSmaller device) then
                                el [ s16, centerX, width (fill |> maximum pointMax) ] (point bottomText)

                            else
                                none

                        Nothing ->
                            none
                    ]
                , column [ p8, s16, centerX, width (fill |> maximum pointMax) ] (List.map point info.points)
                ]
            )
        ]


video info =
    el
        [ if isPhone info.device then
            p4

          else
            p8
        , centerX
        ]
        (column
            [ width
                (if isPhone info.device then
                    fill

                 else
                    maximum 1500 (info.viewportWidth * 0.6 |> round |> px)
                )
            , centerX
            , centerY
            , Border.rounded 10
            , clip
            ]
            [ el [ width fill, height fill, centerX, centerY ]
                (html <|
                    div
                        [ Atr.style "padding" "56.25% 0 0 0"
                        , Atr.style "position" "relative"
                        ]
                        [ iframe
                            [ Atr.style "position" "absolute"
                            , Atr.style "top" "0"
                            , Atr.style "left" "0"
                            , Atr.style "width" "100%"
                            , Atr.style "height" "100%"
                            , attribute "frameborder" "0"
                            , attribute "allow" "autoplay; fullscreen; picture-in-picture"
                            , property "allowfullscreen" (Encode.bool True)
                            , src info.url
                            ]
                            []
                        ]
                )
            ]
        )


footer info =
    (if isPhone info.device then
        column

     else
        row
    )
        [ width fill
        , Background.color info.backgroundColor
        , Font.color white
        , if isPhone info.device then
            Font.center

          else
            Font.alignLeft
        , p4
        , s4
        ]
        [ el [ width (fill |> maximum maxWidth), centerX ] (text info.copyright)
        , Input.button [ centerX ]
            { onPress = Just info.onContactClick
            , label =
                case info.tracker of
                    ContactInfo ->
                        none

                    _ ->
                        text info.contactText
            }
        , download [ width (fill |> maximum maxWidth), alignRight ] { label = text info.downloadText, url = info.downloadLink }
        ]



-- MARKDOWN


markdownView : String -> Result String (List (Element Msg))
markdownView markdownString =
    markdownString
        |> Markdown.Parser.parse
        |> Result.mapError (\error -> error |> List.map Markdown.Parser.deadEndToString |> String.join "\n")
        |> Result.andThen (Markdown.Renderer.render elmUiRenderer)


elmUiRenderer : Markdown.Renderer.Renderer (Element msg)
elmUiRenderer =
    { heading = heading
    , paragraph =
        Element.paragraph
            [ Element.spacing 10 ]
    , thematicBreak = Element.none
    , text = Element.text
    , strong = \content -> Element.row [ Font.bold ] content
    , emphasis = \content -> Element.row [ Font.italic ] content
    , strikethrough = \content -> Element.row [ Font.strike ] content
    , codeSpan = code
    , link =
        \{ title, destination } body ->
            Element.newTabLink
                [ Element.htmlAttribute (Atr.style "display" "inline-flex") ]
                { url = destination
                , label =
                    Element.paragraph
                        [ Font.color (Element.rgb255 0 0 255)
                        ]
                        body
                }
    , hardLineBreak = Html.br [] [] |> Element.html
    , image =
        \image ->
            case image.title of
                Just title ->
                    Element.image [ Element.width Element.fill ] { src = image.src, description = image.alt }

                Nothing ->
                    Element.image [ Element.width Element.fill ] { src = image.src, description = image.alt }
    , blockQuote =
        \children ->
            Element.column
                [ Border.widthEach { top = 0, right = 0, bottom = 0, left = 10 }
                , padding 10
                , Border.color (Element.rgb255 145 145 145)
                , Background.color (Element.rgb255 245 245 245)
                ]
                children
    , unorderedList =
        \items ->
            Element.column [ Element.spacing 15, paddingEach { left = 30, right = 0, bottom = 0, top = 0 } ]
                (items
                    |> List.map
                        (\(ListItem task children) ->
                            Element.row [ Element.spacing 5 ]
                                [ Element.paragraph
                                    [ Element.alignTop ]
                                    ((case task of
                                        IncompleteTask ->
                                            Input.defaultCheckbox False

                                        CompletedTask ->
                                            Input.defaultCheckbox True

                                        NoTask ->
                                            Element.text ""
                                     )
                                        :: Element.text " "
                                        :: children
                                    )
                                ]
                        )
                )
    , orderedList =
        \startingIndex items ->
            Element.column [ Element.spacing 50 ]
                (items
                    |> List.indexedMap
                        (\index itemBlocks ->
                            Element.row [ Element.spacing 5 ]
                                [ Element.paragraph [ Element.alignTop ]
                                    (Element.text (String.fromInt (index + startingIndex) ++ ". ") :: itemBlocks)
                                ]
                        )
                )
    , codeBlock = codeBlock
    , html = Markdown.Html.oneOf []
    , table = Element.column []
    , tableHeader = Element.column []
    , tableBody = Element.column []
    , tableRow = Element.row []
    , tableHeaderCell =
        \maybeAlignment children ->
            Element.paragraph [] children
    , tableCell =
        \maybeAlignment children ->
            Element.paragraph [] children
    }


code : String -> Element msg
code snippet =
    Element.el
        [ Background.color
            (Element.rgba 0 0 0 0.04)
        , Border.rounded 2
        , Element.paddingXY 5 3
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text snippet)


codeBlock : { body : String, language : Maybe String } -> Element msg
codeBlock details =
    Element.el
        [ Background.color (Element.rgba 0 0 0 0.03)
        , Element.htmlAttribute (Atr.style "white-space" "pre")
        , Element.padding 20
        , Font.family
            [ Font.external
                { url = "https://fonts.googleapis.com/css?family=Source+Code+Pro"
                , name = "Source Code Pro"
                }
            ]
        ]
        (Element.text details.body)


heading : { level : Block.HeadingLevel, rawText : String, children : List (Element msg) } -> Element msg
heading { level, rawText, children } =
    Element.paragraph
        [ Font.size
            (case level of
                Block.H1 ->
                    36

                Block.H2 ->
                    24

                _ ->
                    20
            )
        , Font.bold
        , Font.family [ Font.typeface "Montserrat" ]
        , Region.heading (Block.headingLevelToInt level)
        , Font.center
        , Element.htmlAttribute
            (Atr.attribute "name" (rawTextToId rawText))
        , Element.htmlAttribute
            (Atr.id (rawTextToId rawText))
        ]
        children


rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower


setPhoneCursor : String -> String -> Cmd msg
setPhoneCursor oldPhone newPhone =
    let
        parse val =
            String.toList (String.filter isDigit (String.replace "+1" "" val))

        index a =
            a |> Tuple.first

        one a =
            a |> Tuple.second |> Tuple.first

        two a =
            a |> Tuple.second |> Tuple.second
    in
    -- creates List (index, (oldDigit, newDigit)) and filters for first change returning that number
    -- the first difference is what matters, so we just take the head and return the modified index
    case
        List.head
            (List.filterMap
                (\a ->
                    if not (one a == two a) then
                        Just (index a)

                    else
                        Nothing
                )
                (List.indexedMap Tuple.pair (List.map2 Tuple.pair (parse oldPhone) (parse newPhone)))
            )
    of
        Just i ->
            if String.length oldPhone > String.length newPhone then
                Ports.setCursor
                    (case i of
                        0 ->
                            4

                        1 ->
                            5

                        2 ->
                            6

                        3 ->
                            10

                        4 ->
                            11

                        5 ->
                            12

                        n ->
                            n + 10
                    )

            else
                Ports.setCursor
                    (case i of
                        0 ->
                            5

                        1 ->
                            6

                        2 ->
                            10

                        3 ->
                            11

                        4 ->
                            12

                        n ->
                            n + 11
                    )

        Nothing ->
            Cmd.none


contactPhone : String -> String -> String
contactPhone newPhone oldPhone =
    if newPhone == "+1 ( " then
        ""

    else if String.length newPhone < String.length oldPhone then
        newPhone

    else
        prettyPhoneNumber newPhone


prettyPhoneNumber : String -> String
prettyPhoneNumber number =
    let
        clean =
            String.filter isDigit (String.replace "+1" "" number)
    in
    case String.length clean of
        0 ->
            "+1 ("

        1 ->
            "+1 (" ++ clean

        2 ->
            "+1 (" ++ clean

        3 ->
            "+1 (" ++ clean ++ ")  "

        4 ->
            "+1 (" ++ String.left 3 clean ++ ")  " ++ String.right 1 clean

        5 ->
            "+1 (" ++ String.left 3 clean ++ ")  " ++ String.right 2 clean

        _ ->
            "+1 (" ++ String.left 3 clean ++ ")  " ++ String.slice 3 6 clean ++ " - " ++ String.slice 6 10 clean


stackImages acc images color =
    case images of
        first :: rest ->
            stackImages (el [ width fill, height fill, Font.color color, inFront acc ] first) rest (lightenColor 50 color)

        [] ->
            acc


lightenColor by color =
    Element.toRgb color
        |> (\rgb ->
                fromRgb255
                    { red = (rgb.red |> to255) + by
                    , green = (rgb.green |> to255) + by
                    , blue = (rgb.blue |> to255) + by
                    , alpha = 1
                    }
           )
