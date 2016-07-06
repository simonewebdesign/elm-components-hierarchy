module Form.Input.Text exposing (..)

import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (class, for, id, type')
import Html.Events exposing (onInput)


type alias Text = Model

type alias Model =
  { name : String
  , value : String
  }


initialModel : Model
initialModel =
  { name = "defaultName"
  , value = "default value"
  }


type Msg
  = Change String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newValue ->
      { model | value = newValue }


view : Model -> Html Msg
view model =
  div []
      [ label [ for model.name ] [ text model.name ]
      , input [ type' "text"
              , id model.name
              , onInput Change
              ] []
      ]
