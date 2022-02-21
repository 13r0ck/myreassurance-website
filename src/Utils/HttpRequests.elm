module Utils.HttpRequests exposing
    ( postSetup
    , postActivation
    )

import Http
import Json.Decode as Decode

postSetup msg =
    Http.post
        { url = "http://127.0.0.1:8787/stripe/setup"
        , body = Http.emptyBody
        , expect = Http.expectString msg
        }

postActivation msg =
    Http.post
        { url = "http://127.0.0.1:8787/stripe/activation"
        , body = Http.emptyBody
        , expect = Http.expectString msg
        }