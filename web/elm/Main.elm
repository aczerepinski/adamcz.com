module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Time exposing (Time)
import Task
import Json.Encode
import Bio
import Favorites
import Lived


type Msg
    = LoadBio
    | LoadLived
    | LoadTech
    | LoadMusic
    | GoogleMap



-- Model --


type alias Model =
    { topic : String
    , map : String
    }


model : Model
model =
    { topic = "bio"
    , map = "map"
    }


init : ( Model, Cmd Msg )
init =
    ( (Model "bio" "map")
    , Cmd.none
    )



-- View --


topicClasses : Model -> String -> String
topicClasses model topic =
    if topic == model.topic then
        "topic topic--active"
    else
        "topic"


dispatchTopic : Model -> Html Msg
dispatchTopic model =
    case model.topic of
        "bio" ->
            Bio.render

        "lived" ->
            Lived.render

        "tech" ->
            Favorites.tech

        "music" ->
            Favorites.music

        _ ->
            div [] [ text "not found" ]


view : Model -> Html Msg
view model =
    div [ class "about" ]
        [ h2
            [ class "main-title" ]
            [ text "About Adam Czerepinski" ]
        , div
            [ class "about__topics" ]
            [ div [ class (topicClasses model "bio"), onClick (LoadBio) ] [ text "bio" ]
            , div [ class (topicClasses model "tech"), onClick (LoadTech) ] [ text "tech i love" ]
            , div [ class (topicClasses model "music"), onClick (LoadMusic) ] [ text "music i love" ]
            , div [ class (topicClasses model "lived"), onClick (LoadLived) ] [ text "where i've lived" ]
            ]
        , div
            [ class "about__content" ]
            [ dispatchTopic model ]
        ]



-- Subscriptions --


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []



-- Update --


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadBio ->
            { model | topic = "bio" } ! []

        LoadLived ->
            { model | topic = "lived" } ! [ Lived.initMap "" ]

        LoadTech ->
            { model | topic = "tech" } ! []

        LoadMusic ->
            { model | topic = "music" } ! []

        GoogleMap ->
            { model | map = "map" } ! []


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
