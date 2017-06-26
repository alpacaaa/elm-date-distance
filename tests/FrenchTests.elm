module FrenchTests exposing (..)

import Test exposing (..)
import Expect
import Date.Distance exposing (defaultConfig, inWordsWithConfig)
import Date.Distance.Types exposing (Config, Locale)
import Date.Distance.I18n.Fr as French
import Date exposing (Month(..))
import Date.Extra as Date
import Date.Extra as Date exposing (Interval(..))


expectedMsg : String -> String
expectedMsg msg =
    String.split "/" msg
        |> List.head
        |> Maybe.map String.trimRight
        |> Maybe.withDefault msg


t : String -> Config -> Date.Date -> Date.Date -> Test
t msg config d1 d2 =
    test msg <|
        \() ->
            let
                result =
                    inWordsWithConfig config d1 d2
            in
                Expect.equal result (expectedMsg msg)


frenchLocale : Bool -> Config
frenchLocale seconds =
    { defaultConfig
        | locale = French.locale
        , includeSeconds = seconds
    }


frenchLocaleWithPrefix : Bool -> Config
frenchLocaleWithPrefix seconds =
    { defaultConfig
        | locale = French.localeWithPrefix
        , includeSeconds = seconds
    }


lessThan5 : Test
lessThan5 =
    t "moins de 5 secondes"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 3 0)


lessThan10 : Test
lessThan10 =
    t "moins de 10 secondes"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 7 0)


lessThan20 : Test
lessThan20 =
    t "moins de 20 secondes"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 15 0)


halfAMinute : Test
halfAMinute =
    t "moins d'une minute / halfAMinute"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 25 0)


lessThanAMinute : Test
lessThanAMinute =
    t "moins d'une minute / lessThanAMinute"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 45 0)


oneMinute : Test
oneMinute =
    t "1 minute"
        (frenchLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 33 0 0)


lessThanAMinute_ : Test
lessThanAMinute_ =
    t "moins d'une minute / lessThanAMinute no seconds"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 20 0)


oneMinute_ : Test
oneMinute_ =
    t "1 minute / no seconds"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 50 0)


threeMinutes : Test
threeMinutes =
    t "3 minutes"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 34 50 0)


aboutOneHour : Test
aboutOneHour =
    t "environ une heure"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


aboutThreeHours : Test
aboutThreeHours =
    t "environ 3 heures"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 13 32 0 0)


oneDay : Test
oneDay =
    t "1 jour"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 5 10 32 0 0)


threeDays : Test
threeDays =
    t "3 jours"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 7 10 32 0 0)


aboutOneMonth : Test
aboutOneMonth =
    t "environ un mois"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Apr 4 10 32 0 0)


threeMonths : Test
threeMonths =
    t "3 mois"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Jun 4 10 32 0 0)


aboutOneYear : Test
aboutOneYear =
    t "environ un an"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Mar 4 10 32 0 0)


overOneYear : Test
overOneYear =
    t "plus d'un an"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Sep 4 10 32 0 0)


almostThreeYears : Test
almostThreeYears =
    t "près de 3 ans"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Feb 4 10 32 0 0)


aboutThreeYears : Test
aboutThreeYears =
    t "environ 3 ans"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Mar 4 10 32 0 0)


overThreeYears : Test
overThreeYears =
    t "plus de 3 ans"
        (frenchLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Sep 4 10 32 0 0)


halfAMinuteAgo : Test
halfAMinuteAgo =
    t "il y a moins d'une minute"
        (frenchLocaleWithPrefix False)
        (Date.fromParts 1986 Mar 4 10 32 25 0)
        (Date.fromParts 1986 Mar 4 10 32 0 0)


inAboutOneHour : Test
inAboutOneHour =
    t "dans environ une heure"
        (frenchLocaleWithPrefix False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


all : Test
all =
    describe "elm-time-distance in French"
        [ lessThan5
        , lessThan10
        , lessThan20
        , halfAMinute
        , lessThanAMinute
        , oneMinute
        , lessThanAMinute_
        , oneMinute_
        , threeMinutes
        , aboutOneHour
        , aboutThreeHours
        , oneDay
        , threeDays
        , aboutOneMonth
        , threeMonths
        , aboutOneYear
        , overOneYear
        , almostThreeYears
        , aboutThreeYears
        , overThreeYears
        , halfAMinuteAgo
        , inAboutOneHour
        ]
