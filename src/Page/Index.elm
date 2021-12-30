module Page.Index exposing (Data, Model, Msg, page)

import Agreement exposing (agreement)
import Browser.Events
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
import Html exposing (br, div, iframe)
import Html.Attributes as Atr exposing (attribute, class, id, property, src)
import Json.Encode as Encode
import Mailcheck
import Markdown.Block as Block exposing (Block, Inline, ListItem(..), Task(..))
import Markdown.Html
import Markdown.Parser
import Markdown.Renderer
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Palette exposing (isPhone, isTabletOrSmaller, text_sm)
import Process
import Shared
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Simple.Animation.Property as Property
import Simple.Transition as Transition
import Tailwind exposing (..)
import Task
import Utils.Transition as Transition
import View exposing (View)
import Wheel


type alias Model =
    { wheelPercentage : Int
    , signupView : State
    , nameText : String
    , emailText : String
    , addressText : String
    , signupPageTracker : SignUpPage
    , lockScroll : Bool
    , suggestedEmail : Maybe ( String, String, String )
    }


type SignUpPage
    = UserInfo
    | Terms
    | CardConnect


type State
    = Open
    | Closed


type Msg
    = WheelHover Int
    | OpenSignUpView
    | CloseSignUpView
    | UpdateName String
    | UpdateEmail String
    | UpdateAddress String
    | LockScroll ()
    | NextSignUpView
    | FillCorrectEmail


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
    ( { wheelPercentage = 0, signupView = Closed, nameText = "", emailText = "", addressText = "", signupPageTracker = UserInfo, lockScroll = False, suggestedEmail = Nothing }, Cmd.none )


update maybeUrl key sharedModel static msg model =
    case msg of
        WheelHover percentage ->
            ( { model | wheelPercentage = percentage }, Cmd.none )

        OpenSignUpView ->
            ( { model | signupView = Open }, Task.perform LockScroll (Process.sleep 500) )

        CloseSignUpView ->
            ( { model | signupView = Closed, signupPageTracker = UserInfo, lockScroll = False }, Cmd.none )

        UpdateName newName ->
            ( { model | nameText = newName }, Cmd.none )

        UpdateEmail newEmail ->
            ( { model | emailText = newEmail, suggestedEmail = Mailcheck.suggest newEmail }, Cmd.none )

        UpdateAddress newAddress ->
            ( { model | addressText = newAddress }, Cmd.none )

        LockScroll _ ->
            ( { model | lockScroll = True }, Cmd.none )

        NextSignUpView ->
            ( { model
                | signupPageTracker =
                    case model.signupPageTracker of
                        UserInfo ->
                            Terms

                        Terms ->
                            CardConnect

                        CardConnect ->
                            CardConnect
              }
            , Cmd.none
            )

        FillCorrectEmail ->
            ( { model
                | emailText =
                    case model.suggestedEmail of
                        Just ( _, _, email ) ->
                            email

                        Nothing ->
                            model.emailText
                , suggestedEmail = Nothing
              }
            , Cmd.none
            )


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

        footerArgs =
            { backgroundColor = neutral600
            , copyright = "© " ++ String.fromInt sharedModel.currentYear ++ " MyREassurance"
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
                inFront (Lazy.lazy3 signupView sharedModel model { logo = logo, footerArgs = footerArgs, primaryColor = white, secondaryColor = primaryColor }) :: defaultLayout

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
            , video
                { url = "https://player.vimeo.com/video/646433917?h=3bc158f046"
                , viewportWidth = toFloat sharedModel.viewportWidth
                }
            , talkingPoints
                { titleLeft = False
                , primaryColor = white
                , secondaryColor = primaryColor
                , bottomImage = Nothing
                , title = "No listing commissions, ibuyer fees or transfer fees!"
                , callToAction =
                    { image = "/img/right.svg"
                    , description = "arrow"
                    , text = "GET STARTED"
                    }
                , points =
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
                , viewportWidth = viewportWidth
                , viewportHeight = viewportHeight
                , device = device
                }
            , footer
                footerArgs
            ]
        )


signupView sharedModel model info =
    aCol
        (Animation.fromTo
            { duration = 500
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
                , device = sharedModel.device
                }
            , signupScroller
                { nameText = model.nameText
                , emailText = model.emailText
                , addressText = model.addressText
                , suggestedEmail = model.suggestedEmail
                , signupPageTracker = model.signupPageTracker
                , fullDate = sharedModel.fullDate
                , device = sharedModel.device
                }
            , nextButton
                { primaryColor = info.primaryColor, secondaryColor = info.secondaryColor, signupPageTracker = model.signupPageTracker, device = sharedModel.device, emailText = model.emailText, nameText = model.nameText, addressText = model.addressText, suggestedEmail = model.suggestedEmail }
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

        frame =
            column
                [ Background.color white
                , pad
                , s16
                , centerX
                , width (fill |> maximum 800)
                , Font.color slate700
                , Border.rounded 20
                , Border.shadow { offset = ( 5, 10 ), size = 5, blur = 20, color = slate300 }
                ]
    in
    frame
        (case info.signupPageTracker of
            UserInfo ->
                [ column [ width fill ]
                    [ Input.text
                        [ Font.color slate900
                        , below
                            (Input.button [ alignRight, text_xs, Font.color red500 ]
                                { onPress = Just FillCorrectEmail
                                , label =
                                    text
                                        (case info.suggestedEmail of
                                            Just ( _, _, email ) ->
                                                "Did you mean " ++ email ++ "?"

                                            Nothing ->
                                                ""
                                        )
                                }
                            )
                        ]
                        { onChange = UpdateEmail, text = info.emailText, placeholder = Nothing, label = Input.labelAbove [] (el [ Font.bold, text_xs ] (text "Email")) }
                    ]
                , Input.text [ Font.color slate900 ] { onChange = UpdateName, text = info.nameText, placeholder = Nothing, label = Input.labelAbove [] (el [ Font.bold, text_xs ] (text "Name")) }
                , Input.text [ Font.color slate900 ] { onChange = UpdateAddress, text = info.addressText, placeholder = Nothing, label = Input.labelAbove [] (el [ Font.bold, text_xs ] (text "Home Address")) }
                ]

            Terms ->
                case markdownView (Agreement.agreement |> String.replace "[CUSTOMER NAME]" info.nameText |> String.replace "[DATE]" info.fullDate |> String.replace "[ADDRESS]" info.addressText) of
                    Ok rendered ->
                        rendered

                    Err errors ->
                        [ column [ Font.center, s8, centerX, Font.color red500 ] [ el [ centerX ] (text "View failed. Please contact website administrator."), el [ centerX ] (text errors) ] ]

            CardConnect ->
                [ text "This is a placeholder for the CardConnect iframe" ]
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
            "By clicking “" ++ consentButtonText ++ "” you agree to the Services Subscription agreement above."

        button mainColor secondaryColor action =
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
                            [ text consentButtonText
                            ]
                        )
                }

        activeButton =
            button info.secondaryColor info.primaryColor (Just NextSignUpView)

        disabledButton =
            button slate300 slate500 Nothing
    in
    column [ centerX, p8, width (fill |> maximum 450), s8 ]
        (case info.signupPageTracker of
            UserInfo ->
                if String.length info.nameText >= 5 && String.length info.emailText > 5 && String.length info.addressText > 5 && info.suggestedEmail == Nothing then
                    [ activeButton ]

                else
                    [ disabledButton ]

            Terms ->
                [ paragraph [ Font.center, Font.color slate500, text_xs ] [ text consentText ]
                , activeButton
                ]

            CardConnect ->
                []
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


video info =
    el [ p16, centerX ]
        (column
            [ width (maximum maxWidth (info.viewportWidth * 0.6 |> round |> px))
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
    el [ width fill, Background.color info.backgroundColor, Font.color white, p4 ]
        (el [ width (fill |> maximum maxWidth), centerX ] (text info.copyright))



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
                [ Element.htmlAttribute (Html.Attributes.style "display" "inline-flex") ]
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
            Element.column [ Element.spacing 15 ]
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
        , Element.htmlAttribute (Html.Attributes.style "white-space" "pre")
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
            (Html.Attributes.attribute "name" (rawTextToId rawText))
        , Element.htmlAttribute
            (Html.Attributes.id (rawTextToId rawText))
        ]
        children


rawTextToId rawText =
    rawText
        |> String.split " "
        |> String.join "-"
        |> String.toLower
