port module Lived exposing (..)

import Json.Encode
import Html exposing (..)
import Html.Attributes exposing (class)


port initMap : String -> Cmd msg


port acceptMap : (Json.Encode.Value -> msg) -> Sub msg


render : Html msg
render =
    div [ class "map-wrapper" ]
        [ p [] [ text "Click the map markers for more info on the places I've lived." ]
        , div [ Html.Attributes.id "map-goes-here" ] [ text "map goes here" ]
        ]
