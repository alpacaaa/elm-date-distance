module Date.Distance.I18n.Sv
    exposing
        ( LocaleConfig
        , locale
        )

{-| Swedish locale. Used by default.
@docs LocaleConfig
@docs locale
-}

import Date.Distance.Types exposing (DistanceLocale(..), Locale)
import Date.Extra as Date exposing (Interval(..))


{-| Configure the localization function.

  - `addAffix` – turns `2 dagar` into `2 dagar sedan` or `om 2 dagar`

-}
type alias LocaleConfig =
    { addAffix : Bool }


{-| Configure the Swedish locale.

    locale =
        I18n.Sv.locale { addAffix = True }

    inWords =
        { defaultConfig | locale = locale }
            |> inWordsWithConfig

-}
locale : LocaleConfig -> Locale
locale { addAffix } order distance =
    let
        result =
            locale_ distance
    in
    if addAffix then
        if order == LT then
            "om " ++ result
        else
            result ++ " sedan"
    else
        result


locale_ : DistanceLocale -> String
locale_ distance =
    case distance of
        LessThanXSeconds i ->
            circa "mindre än" Second i

        HalfAMinute ->
            "en halv minut"

        LessThanXMinutes i ->
            circa "mindre än" Minute i

        XMinutes i ->
            exact Minute i

        AboutXHours i ->
            circa "ungefär" Hour i

        XDays i ->
            exact Day i

        AboutXMonths i ->
            circa "ungefär" Month i

        XMonths i ->
            exact Month i

        AboutXYears i ->
            circa "ungefär" Year i

        OverXYears i ->
            circa "över" Year i

        AlmostXYears i ->
            circa "nästan" Year i


formatInterval : Interval -> String
formatInterval interval =
    case interval of
        Millisecond ->
            "millisekund"

        Second ->
            "sekund"

        Minute ->
            "minut"

        Hour ->
            "timm"

        Day ->
            "dag"

        Week ->
            "vecka"

        Month ->
            "månad"

        Year ->
            "år"

        Quarter ->
            "kvartal"

        Monday ->
            "måndag"

        Tuesday ->
            "tisdag"

        Wednesday ->
            "onsdag"

        Thursday ->
            "torsdag"

        Friday ->
            "fredag"

        Saturday ->
            "lördag"

        Sunday ->
            "söndag"


singular : Interval -> String
singular interval =
    case interval of
        Millisecond ->
            "en " ++ formatInterval interval

        Second ->
            "en " ++ formatInterval interval

        Minute ->
            "en " ++ formatInterval interval

        Hour ->
            "en " ++ formatInterval interval ++ "e"

        Day ->
            "en " ++ formatInterval interval

        Week ->
            "en " ++ formatInterval interval

        Month ->
            "en " ++ formatInterval interval

        Year ->
            "ett " ++ formatInterval interval

        Quarter ->
            "ett " ++ formatInterval interval

        Monday ->
            "en " ++ formatInterval interval

        Tuesday ->
            "en " ++ formatInterval interval

        Wednesday ->
            "en " ++ formatInterval interval

        Thursday ->
            "en " ++ formatInterval interval

        Friday ->
            "en " ++ formatInterval interval

        Saturday ->
            "en " ++ formatInterval interval

        Sunday ->
            "en " ++ formatInterval interval


plural : Interval -> String
plural interval =
    case interval of
        Millisecond ->
            formatInterval interval ++ "er"

        Second ->
            formatInterval interval ++ "er"

        Minute ->
            formatInterval interval ++ "er"

        Hour ->
            formatInterval interval ++ "ar"

        Day ->
            formatInterval interval ++ "ar"

        Week ->
            formatInterval interval ++ "or"

        Month ->
            formatInterval interval ++ "er"

        Year ->
            formatInterval interval

        Quarter ->
            formatInterval interval

        Monday ->
            formatInterval interval ++ "ar"

        Tuesday ->
            formatInterval interval ++ "ar"

        Wednesday ->
            formatInterval interval ++ "ar"

        Thursday ->
            formatInterval interval ++ "ar"

        Friday ->
            formatInterval interval ++ "ar"

        Saturday ->
            formatInterval interval ++ "ar"

        Sunday ->
            formatInterval interval ++ "ar"


circa : String -> Interval -> Int -> String
circa prefix interval i =
    case i of
        1 ->
            prefix ++ " " ++ singular interval

        _ ->
            prefix ++ " " ++ toString i ++ " " ++ plural interval


exact : Interval -> Int -> String
exact interval i =
    case i of
        1 ->
            singular interval

        _ ->
            toString i ++ " " ++ plural interval
