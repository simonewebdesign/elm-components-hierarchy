module Form.Input exposing (..)

import Html exposing (Html)
import Html.App as Html
import Form.Input.DatePicker exposing (DatePicker)
import Form.Input.Number exposing (Number)
import Form.Input.Text exposing (Text)

type Input
  = IDatePicker DatePicker
  | INumber Number
  | IText Text

type Msg
  = MDatePicker Form.Input.DatePicker.Msg
  | MNumber Form.Input.Number.Msg
  | MText Form.Input.Text.Msg

-- TODO: update

view : Input -> Html Msg
view model =
  case model of
    IDatePicker mdl ->
      Html.map MDatePicker (Form.Input.DatePicker.view mdl)

    INumber mdl ->
      Html.map MNumber (Form.Input.Number.view mdl)

    IText mdl ->
      Html.map MText (Form.Input.Text.view mdl)
