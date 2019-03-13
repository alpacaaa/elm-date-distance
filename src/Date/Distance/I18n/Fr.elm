module Date.Distance.I18n.Fr exposing
    ( LocaleConfig
    , locale
    )

{-| French locale.

@docs LocaleConfig
@docs locale

-}

import Date.Distance.Types exposing (DistanceLocale(..), Interval(..), Locale)


{-| Configure the localization function.

  - `addPrefix` – turns `2 jours` into `il y a 2 jours` or `dans 2 jours`

-}
type alias LocaleConfig =
    { addPrefix : Bool }


{-| Configure the French locale.

    locale =
        I18n.Fr.locale { addPrefix = True }

    inWords =
        { defaultConfig | locale = locale }
            |> inWordsWithConfig

-}
locale : LocaleConfig -> Locale
locale { addPrefix } order distance =
    let
        result =
            localeHelp distance
    in
    if addPrefix then
        if order == LT then
            "dans " ++ result

        else
            "il y a " ++ result

    else
        result


localeHelp : DistanceLocale -> String
localeHelp distance =
    case distance of
        LessThanXSeconds i ->
            circa
                (if i == 1 then
                    "moins d'"

                 else
                    "moins de "
                )
                Second
                i

        HalfAMinute ->
            "moins d'une minute"

        LessThanXMinutes i ->
            circa
                (if i == 1 then
                    "moins d'"

                 else
                    "moins de "
                )
                Minute
                i

        XMinutes i ->
            exact Minute i

        AboutXHours i ->
            circa "environ " Hour i

        XDays i ->
            exact Day i

        AboutXMonths i ->
            circa "environ " Month i

        XMonths i ->
            exact Month i

        AboutXYears i ->
            circa "environ " Year i

        OverXYears i ->
            circa
                (if i == 1 then
                    "plus d'"

                 else
                    "plus de "
                )
                Year
                i

        AlmostXYears i ->
            circa
                (if i == 1 then
                    "près d'"

                 else
                    "près de "
                )
                Year
                i


formatInterval : Interval -> String
formatInterval interval =
    case interval of
        Second ->
            "seconde"

        Minute ->
            "minute"

        Hour ->
            "heure"

        Day ->
            "jour"

        Month ->
            "mois"

        Year ->
            "an"


singular : Interval -> String
singular interval =
    case interval of
        Second ->
            feminine interval

        Minute ->
            feminine interval

        Hour ->
            feminine interval

        _ ->
            masculine interval


feminine : Interval -> String
feminine interval =
    "une " ++ formatInterval interval


masculine : Interval -> String
masculine interval =
    "un " ++ formatInterval interval


pluralizeInterval : Interval -> String
pluralizeInterval interval =
    if interval /= Month then
        "s"

    else
        ""


circa : String -> Interval -> Int -> String
circa prefix interval i =
    case i of
        1 ->
            prefix ++ singular interval

        _ ->
            prefix ++ String.fromInt i ++ " " ++ formatInterval interval ++ pluralizeInterval interval


exact : Interval -> Int -> String
exact interval i =
    case i of
        1 ->
            "1 " ++ formatInterval interval

        _ ->
            String.fromInt i ++ " " ++ formatInterval interval ++ pluralizeInterval interval
