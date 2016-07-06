module Form.Wrapper exposing (..)

import Html exposing (Html)
import Html.App as Html
import Form.Wrapper.Fieldset

type Wrapper
  = WFieldset Form.Wrapper.Fieldset.Model

type Msg
  = MFieldset Form.Wrapper.Fieldset.Msg

-- TODO: update

view : Wrapper -> Html Msg
view model =
  case model of
    WFieldset mdl ->
      Html.map MFieldset (Form.Wrapper.Fieldset.view mdl)
