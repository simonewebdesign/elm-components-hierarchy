import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Form


main : Program Never
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { form : Form.Model
  }


initialModel : Model
initialModel =
  { form = Form.initialModel
  }


init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )


-- UPDATE

type Msg
  = FormMsg Form.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    FormMsg subMsg ->
      { model | form = Form.update subMsg model.form } ! []


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ text "Hello, world!"
    , text (toString model)
    , Html.map FormMsg (Form.view model.form)
    ]
