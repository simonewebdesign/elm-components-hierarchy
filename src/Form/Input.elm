module Form.Input exposing (..)

import Html exposing (Html)
import Html.App as Html
import Form.Input.DatePicker exposing (DatePicker)
import Form.Input.Number exposing (Number)
import Form.Input.Text exposing (Text)

type alias Model = Input

type Input
  = IDatePicker DatePicker
  | INumber Number
  | IText Text

type Msg
  = MDatePicker Form.Input.DatePicker.Msg
  | MNumber Form.Input.Number.Msg
  | MText Form.Input.Text.Msg


update : Msg -> Model -> Model
update message model =
  case message of
    MDatePicker msg ->
      case model of
        IDatePicker mdl ->
          IDatePicker <| Form.Input.DatePicker.update msg mdl

        _ -> IDatePicker Form.Input.DatePicker.initialModel

    MNumber msg ->
      case model of
        INumber mdl ->
          INumber <| Form.Input.Number.update msg mdl

        _ -> INumber Form.Input.Number.initialModel

    MText msg ->
      case model of
        IText mdl ->
          IText <| Form.Input.Text.update msg mdl

        _ -> IText Form.Input.Text.initialModel


view : Model -> Html Msg
view model =
  case model of
    IDatePicker mdl ->
      Html.map MDatePicker (Form.Input.DatePicker.view mdl)

    INumber mdl ->
      Html.map MNumber (Form.Input.Number.view mdl)

    IText mdl ->
      Html.map MText (Form.Input.Text.view mdl)
