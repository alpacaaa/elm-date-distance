module SwedishTests exposing (..)

import Date exposing (Month(..))
import Date.Distance exposing (defaultConfig, inWordsWithConfig)
import Date.Distance.I18n.Sv as Swedish
import Date.Distance.Types exposing (Config, Locale)
import Date.Extra as Date exposing (Interval(..))
import Expect
import Test exposing (..)


testMsg : Config -> String -> String
testMsg config msg =
    if config.includeSeconds then
        msg ++ " (with seconds)"
    else
        msg


t : String -> Config -> Date.Date -> Date.Date -> Test
t msg config d1 d2 =
    test (testMsg config msg) <|
        \() ->
            let
                result =
                    inWordsWithConfig config d1 d2
            in
            Expect.equal result msg


swedishLocale : Bool -> Config
swedishLocale seconds =
    { defaultConfig
        | locale = Swedish.locale { addAffix = False }
        , includeSeconds = seconds
    }


swedishLocaleWithPrefix : Bool -> Config
swedishLocaleWithPrefix seconds =
    { defaultConfig
        | locale = Swedish.locale { addAffix = True }
        , includeSeconds = seconds
    }


lessThan5 : Test
lessThan5 =
    t "mindre än 5 sekunder"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 3 0)


lessThan10 : Test
lessThan10 =
    t "mindre än 10 sekunder"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 7 0)


lessThan20 : Test
lessThan20 =
    t "mindre än 20 sekunder"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 15 0)


halfAMinute : Test
halfAMinute =
    t "en halv minut"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 25 0)


lessThanAMinute : Test
lessThanAMinute =
    t "mindre än en minut"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 45 0)


oneMinute : Test
oneMinute =
    t "en minut"
        (swedishLocale True)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 33 0 0)


lessThanAMinute_ : Test
lessThanAMinute_ =
    t "mindre än en minut"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 20 0)


oneMinute_ : Test
oneMinute_ =
    t "en minut"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 32 50 0)


threeMinutes : Test
threeMinutes =
    t "3 minuter"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 10 34 50 0)


aboutOneHour : Test
aboutOneHour =
    t "ungefär en timme"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


aboutThreeHours : Test
aboutThreeHours =
    t "ungefär 3 timmar"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 13 32 0 0)


oneDay : Test
oneDay =
    t "en dag"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 5 10 32 0 0)


threeDays : Test
threeDays =
    t "3 dagar"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 7 10 32 0 0)


aboutOneMonth : Test
aboutOneMonth =
    t "ungefär en månad"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Apr 4 10 32 0 0)


threeMonths : Test
threeMonths =
    t "3 månader"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Jun 4 10 32 0 0)


aboutOneYear : Test
aboutOneYear =
    t "ungefär ett år"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Mar 4 10 32 0 0)


overOneYear : Test
overOneYear =
    t "över ett år"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1987 Sep 4 10 32 0 0)


almostThreeYears : Test
almostThreeYears =
    t "nästan 3 år"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Feb 4 10 32 0 0)


aboutThreeYears : Test
aboutThreeYears =
    t "ungefär 3 år"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Mar 4 10 32 0 0)


overThreeYears : Test
overThreeYears =
    t "över 3 år"
        (swedishLocale False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1989 Sep 4 10 32 0 0)


localeWithAffix : Locale
localeWithAffix =
    Swedish.locale { addAffix = True }


halfAMinuteAgo : Test
halfAMinuteAgo =
    t "en halv minut sedan"
        (swedishLocaleWithPrefix True)
        (Date.fromParts 1986 Mar 4 10 32 25 0)
        (Date.fromParts 1986 Mar 4 10 32 0 0)


inAboutOneHour : Test
inAboutOneHour =
    t "om ungefär en timme"
        (swedishLocaleWithPrefix False)
        (Date.fromParts 1986 Mar 4 10 32 0 0)
        (Date.fromParts 1986 Mar 4 11 32 0 0)


all : Test
all =
    describe "elm-time-distance"
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
