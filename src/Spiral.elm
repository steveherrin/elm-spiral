module Main exposing (..)

import Collage
import Color
import Element
import Html exposing (Html, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { levels : Int
    }


model : Model
model =
    Model 1


type Msg
    = AddLevel
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddLevel ->
            { model | levels = model.levels + 1 }

        Reset ->
            { model | levels = 1 }


phi =
    (1 + sqrt 5) / 2


type alias Point =
    { r : Float
    , theta : Float
    }


constrainTheta : Float -> Float
constrainTheta theta =
    theta - toFloat (floor (theta / 2 * pi))


spiral : Int -> List Point
spiral levels =
    let
        makePoint : Int -> Point
        makePoint i =
            { r = toFloat i, theta = constrainTheta (2 * pi * phi * toFloat i) }
    in
    List.map makePoint (List.range 0 levels)


toElmCoordinates : Point -> ( Float, Float )
toElmCoordinates { r, theta } =
    ( r * cos theta
    , r * sin theta
    )


view : Model -> Html.Html Msg
view model =
    let
        path =
            spiral model.levels
                |> List.map toElmCoordinates
                |> Collage.path
                |> Collage.traced (Collage.solid Color.black)
    in
    div [ onClick AddLevel ]
        [ Collage.collage 600 400 [ path ] |> Element.toHtml
        , text (toString model.levels)
        ]
