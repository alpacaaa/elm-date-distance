module Date.Distance.I18n.Sv exposing
    ( LocaleConfig
    , locale
    )

{-| Swedish locale. Used by default.

@docs LocaleConfig
@docs locale

-}

import Date.Distance.Types exposing (DistanceLocale(..), Interval(..), Locale)


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
        Second ->
            "sekund"

        Minute ->
            "minut"

        Hour ->
            "timm"

        Day ->
            "dag"

        Month ->
            "månad"

        Year ->
            "år"


singular : Interval -> String
singular interval =
    case interval of
        Second ->
            "en " ++ formatInterval interval

        Minute ->
            "en " ++ formatInterval interval

        Hour ->
            "en " ++ formatInterval interval ++ "e"

        Day ->
            "en " ++ formatInterval interval

        Month ->
            "en " ++ formatInterval interval

        Year ->
            "ett " ++ formatInterval interval


plural : Interval -> String
plural interval =
    case interval of
        Second ->
            formatInterval interval ++ "er"

        Minute ->
            formatInterval interval ++ "er"

        Hour ->
            formatInterval interval ++ "ar"

        Day ->
            formatInterval interval ++ "ar"

        Month ->
            formatInterval interval ++ "er"

        Year ->
            formatInterval interval


circa : String -> Interval -> Int -> String
circa prefix interval i =
    case i of
        1 ->
            prefix ++ " " ++ singular interval

        _ ->
            prefix ++ " " ++ String.fromInt i ++ " " ++ plural interval


exact : Interval -> Int -> String
exact interval i =
    case i of
        1 ->
            singular interval

        _ ->
            String.fromInt i ++ " " ++ plural interval
