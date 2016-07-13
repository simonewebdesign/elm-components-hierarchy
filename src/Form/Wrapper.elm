module Form.Wrapper exposing (..)

import Html exposing (Html)
import Html.App as Html
import Form.Wrapper.Fieldset

type alias Model = Wrapper

type Wrapper
  = WFieldset Form.Wrapper.Fieldset.Model

type Msg
  = MFieldset Form.Wrapper.Fieldset.Msg

update : Msg -> Model -> Model
update message model =
  case message of
    MFieldset msg ->
      case model of
        WFieldset mdl ->
          WFieldset <| Form.Wrapper.Fieldset.update msg mdl


view : Wrapper -> Html Msg
view model =
  case model of
    WFieldset mdl ->
      Html.map MFieldset (Form.Wrapper.Fieldset.view mdl)
