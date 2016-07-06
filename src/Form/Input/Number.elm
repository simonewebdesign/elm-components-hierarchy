module Form.Input.Number exposing (..)

import String
import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (class, for, id, type')
import Html.Events exposing (onInput)

type alias Number = Model

type alias Model =
  { name : String
  , value : Int
  }


initialModel : Model
initialModel =
  { name = "defaultName"
  , value = 0
  }


type Msg
  = Change Int


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newValue ->
      { model | value = newValue }


view : Model -> Html Msg
view model =
  div []
      [ label [ for model.name ] [ text model.name ]
      , input [ type' "number"
              , id model.name
              , onInput (\val -> Change <|
                  case String.toInt val of
                    Ok int -> int
                    Err err -> 0
                )
              ] []
      ]
