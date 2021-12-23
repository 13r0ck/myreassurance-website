module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Events
import Browser.Navigation
import DataSource
import Element exposing (Device, DeviceClass(..), classifyDevice)
import Html exposing (Html)
import Json.Decode as Decode
import Json.Encode as Encode
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Palette
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg
    | WindowResized Int Int


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { viewportWidth : Int
    , viewportHeight : Int
    , currentYear : Int
    , device : DeviceClass
    }


defaultModel =
    -- arbitraty values
    { viewportWidth = 1920
    , viewportHeight = 1080
    , currentYear = 1969
    , device = Desktop
    }


decodeModel decodeValue =
    let
        decodedValue =
            Decode.decodeValue
                (Decode.map3
                    (\w h y ->
                        { viewportWidth = w
                        , viewportHeight = h
                        , currentYear = y
                        , device = (Palette.classifyDevice { height = h, width = w }).class
                        }
                    )
                    (Decode.field "width" Decode.int)
                    (Decode.field "height" Decode.int)
                    (Decode.field "currentYear" Decode.int)
                )
                decodeValue
    in
    case decodedValue of
        Ok val ->
            val

        Err _ ->
            defaultModel


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    let
        flagModel =
            case flags of
                Pages.Flags.BrowserFlags val ->
                    decodeModel val

                Pages.Flags.PreRenderFlags ->
                    defaultModel
    in
    ( flagModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( model, Cmd.none )

        SharedMsg globalMsg ->
            ( model, Cmd.none )

        WindowResized w h ->
            ( { model | viewportWidth = w, viewportHeight = h, device = (Palette.classifyDevice { height = h, width = w }).class }, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Browser.Events.onResize WindowResized


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html msg, title : String }
view sharedData page model toMsg pageView =
    { body = Html.div [] pageView.body
    , title = pageView.title
    }
