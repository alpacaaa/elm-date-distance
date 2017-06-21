port module Main exposing (..)

import Test
import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import EnglishTests
import FrenchTests


main : Test.Runner.Node.TestProgram
main =
    run emit <|
        Test.describe "Test the elm-date-distance module"
            [ Test.describe "Test the default English localization"
                [ EnglishTests.all ]
            , Test.describe "Test the French localization"
                [ FrenchTests.all ]
            ]


port emit : ( String, Value ) -> Cmd msg
