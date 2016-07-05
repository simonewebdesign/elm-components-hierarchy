module Form.Wrapper.Fieldset exposing (..)

import Html.App as Html
import Html exposing (Html, div, input, label, text, fieldset, legend)
import Html.Attributes exposing (class, for, id, type')

import Form.Input.Text
import Form.Input.Number


type alias Model =
  { name : String
  , textInputs : List IndexedInputText
  , numberInputs : List IndexedInputNumber
  }


type alias ID =
  String

type alias IndexedInputText =
  ( ID, Form.Input.Text.Model )

type alias IndexedInputNumber =
  ( ID, Form.Input.Number.Model )


initialModel : Model
initialModel =
  { name = "defaultFieldsetName"
  , textInputs =
      [ ( "someTextField"
        , { name = "someTextField", value = "Some initial value" }
        )
      , ( "someAnotherTextField"
        , { name = "someAnotherTextField", value = "Some another initial value" }
        )
      ]
  , numberInputs =
      [ ( "someNumberField"
        , { name = "someNumberField", value = 123 }
        )
      , ( "someAnotherNumberField"
        , { name = "someAnotherNumberField", value = 456 }
        )
      ]
  }


type Msg
  = InputTextMsg ID Form.Input.Text.Msg
  | InputNumberMsg ID Form.Input.Number.Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    InputTextMsg id subMsg ->
      let
        updateInput =
          \( subId, subModel ) ->
            if subId == id then
              ( id, Form.Input.Text.update subMsg subModel )
            else
              ( id, subModel )
      in
        { model | textInputs = List.map updateInput model.textInputs }

    InputNumberMsg id subMsg ->
      let
        updateInput =
          \( subId, subModel ) ->
            if subId == id then
              ( id, Form.Input.Number.update subMsg subModel )
            else
              ( id, subModel )
      in
        { model | numberInputs = List.map updateInput model.numberInputs }


view : Model -> Html Msg
view model =
  fieldset []
      [ legend [] [ text model.name ]
      , div [] <|
        (List.map viewTextInput model.textInputs) ++
        (List.map viewNumberInput model.numberInputs)
      ]


viewTextInput : IndexedInputText -> Html Msg
viewTextInput =
  \( id, model ) ->
    Html.map (InputTextMsg id) (Form.Input.Text.view model)


viewNumberInput : IndexedInputNumber -> Html Msg
viewNumberInput =
  \( id, model ) ->
    Html.map (InputNumberMsg id) (Form.Input.Number.view model)
