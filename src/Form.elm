module Form exposing (..)

import Html exposing (Html, div, input, label, text, form)
import Html.App as Html
import Html.Attributes exposing (class, for, id, type')
import Html.Events exposing (onInput)

import Form.Input exposing (..)
import Form.Wrapper exposing (..)

-- just because we need the initialModel for demo
import Form.Wrapper.Fieldset

-- because we are updating each single model separately, which is a bit weird
import Form.Input.DatePicker
import Form.Input.Number
import Form.Input.Text
-- TODO: We're going to need an extra layer (Form.Section probably)


type alias Model =
  { inputs : List IndexedInput
  , wrappers : List IndexedWrapper
  }

type alias ID = Int
type alias IndexedInput = ( ID, Form.Input.Input )
type alias IndexedWrapper = ( ID, Form.Wrapper.Wrapper )

-- Just dummy data
initialModel : Model
initialModel =
  { inputs =
      [ ( 0
        , IText { name = "someTextField", value = "Some initial value" }
        )
      , ( 1
        , IText { name = "someAnotherTextField", value = "Some another initial value" }
        )
      , ( 2
        , INumber { name = "someNumberField", value = 123 }
        )
      , ( 3
        , INumber { name = "someAnotherNumberField", value = 456 }
        )
      ]
  , wrappers =
      [ ( 0
        , WFieldset
            Form.Wrapper.Fieldset.initialModel
        )
      , ( 1
        , WFieldset
            { name = "some fieldset defined in the form's initial model"
            , textInputs =
                [ ( "fubarText"
                  , { name = "someTextFieldBlah", value = "Some initial value" }
                  )
                , ( "fubazText"
                  , { name = "someAnotherTextFieldBlah", value = "Some another initial value" }
                  )
                ]
            , numberInputs =
                [ ( "someNumberFieldFubar"
                  , { name = "someNumberField111", value = 111 }
                  )
                , ( "someAnotherNumberFieldFubaz"
                  , { name = "someAnotherNumberField222", value = 222 }
                  )
                ]
            }
        )
      ]
  }


type Msg
  = InputMsg ID Form.Input.Msg
  | WrapperMsg ID Form.Wrapper.Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    InputMsg id subMsg ->
      let
        subUpdate =
          \( subId, subModel ) ->
            if subId == id then
              case subModel of
                IDatePicker subMdl ->
                  let
                    sMsg =
                      case subMsg of
                        MDatePicker m -> m
                        _ -> Form.Input.DatePicker.Change "DAMMIT!"
                  in
                    ( id, IDatePicker <| Form.Input.DatePicker.update sMsg subMdl )

                INumber subMdl ->
                  let
                    sMsg =
                      case subMsg of
                        MNumber m -> m
                        _ -> Form.Input.Number.Change -1
                  in
                    ( id, INumber <| Form.Input.Number.update sMsg subMdl )

                IText subMdl ->
                  let
                    sMsg =
                      case subMsg of
                        MText m -> m
                        _ -> Form.Input.Text.Change "ARGH!"
                  in
                    ( id, IText <| Form.Input.Text.update sMsg subMdl )
            else
              ( id, subModel )
      in
        { model | inputs = List.map subUpdate model.inputs }

    WrapperMsg id subMsg ->
      let
        subUpdate =
          \( subId, subModel ) ->
            if subId == id then
              case subModel of
                WFieldset subMdl ->
                  let
                    sMsg =
                      case subMsg of
                        MFieldset m -> m
                  in
                    ( id, WFieldset <| Form.Wrapper.Fieldset.update sMsg subMdl )
            else
              ( id, subModel )
      in
        { model | wrappers = List.map subUpdate model.wrappers }


view : Model -> Html Msg
view model =
  form [] <|
    (List.map viewInput model.inputs) ++
    (List.map viewWrapper model.wrappers)


viewInput : IndexedInput -> Html Msg
viewInput ( id, model ) =
  Html.map (InputMsg id) (Form.Input.view model)


viewWrapper : IndexedWrapper -> Html Msg
viewWrapper ( id, model ) =
  Html.map (WrapperMsg id) (Form.Wrapper.view model)
