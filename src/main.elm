module Main exposing (..)

import Html exposing (Html, button, div, input, text, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { newTodoField : String, todoList : List Todo }


model : Model
model =
    { newTodoField = ""
    , todoList = []
    }


type alias Todo =
    { content : String, done : Bool }


type Msg
    = TextInput String
    | NewTodo String
    | RemoveTodo Todo


update : Msg -> Model -> Model
update msg model =
    case msg of
        TextInput string ->
            { model | newTodoField = string }

        NewTodo newTodoContent ->
            { model | todoList = { content = newTodoContent, done = False } :: model.todoList }

        RemoveTodo selectedTodo ->
            { model | todoList = (List.filter (\a -> a /= selectedTodo) model.todoList) }


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ onInput TextInput, type_ "text", placeholder "new todo element", myStyle ] []
            , button [ onClick (NewTodo model.newTodoField) ] [ text "Add" ]
            ]
        , div []
            [ viewTodoList model.todoList ]
        ]


viewTodoList todoList =
    ul []
        (List.map
            (\todoElem -> li [ onClick (RemoveTodo todoElem) ] [ text todoElem.content ])
            todoList
        )


myStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "40px" )
        , ( "padding", "10px 0" )
        , ( "font-size", "2em" )
        , ( "text-align", "center" )
        ]
