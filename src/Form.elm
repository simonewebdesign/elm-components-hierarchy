module Form exposing (..)

import Html exposing (Html, div, input, label, text, form)
import Html.App as Html
import Html.Attributes exposing (class, for, id, type')
import Html.Events exposing (onInput)

import Form.Input exposing (..)
import Form.Wrapper exposing (..)

-- just because we need the initialModel for demo
import Form.Wrapper.Fieldset


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
      [
        --( 0
        --, WFieldset
        --    Form.Wrapper.Fieldset.initialModel
        --)
        ( 1
        , WFieldset
            { name = "some fieldset defined in the form's initial model"
            , textInputs =
                [ ( 60
                  , { name = "someTextFieldBlah", value = "Some initial value" }
                  )
                , ( 70
                  , { name = "someAnotherTextFieldBlah", value = "Some another initial value" }
                  )
                ]
            , numberInputs =
                [ ( 80
                  , { name = "someNumberField111", value = 111 }
                  )
                , ( 90
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
update message model =
  case message of
    InputMsg id msg ->
      let
        subUpdate ( subId, subModel ) =
          if subId == id then
            ( subId, Form.Input.update msg subModel )
          else
            ( subId , subModel )
      in
        { model | inputs = List.map subUpdate model.inputs }

    WrapperMsg id msg ->
      let
        subUpdate ( subId, subModel ) =
          if subId == id then
            ( subId, Form.Wrapper.update msg subModel )
          else
            ( subId , subModel )
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
