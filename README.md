# elm-date-distance

Distance between dates in words.
Compare two dates and gives back results like:
- `5 minutes ago`
- `about 1 hour`
- `in 3 months`

Compatible with the core [Date type](http://package.elm-lang.org/packages/elm-lang/core/latest/Date).

## Installation

```sh
elm-package install alpacaaa/elm-date-distance
```

## Usage

```elm
import Date.Distance as Distance

-- Date.Extra is not required, you can create Date objects however you prefer
import Date.Extra as Date

date1 = Date.fromParts 2017 May 5 10 20 0 0
date2 = Date.fromParts 2017 May 7 10 20 0 0

Distance.inWords date1 date2 == "2 days"
```

You can also use a custom configuration
([Config docs](http://package.elm-lang.org/packages/alpacaaa/elm-date-distance/latest/Date-Distance-Types#Config)).

```elm
date1 = Date.fromParts 2017 May 7 10 20 0 0
date2 = Date.fromParts 2017 May 7 10 20 15 0

inWords = { Distance.defaultConfig | includeSeconds = True}
    |> Distance.inWordsWithConfig

inWords date1 date2 == "less than 20 seconds"
```

The default configuration will give you the following results.

| Distance between dates                   | Result              |
| ---------------------------------------- | ------------------- |
| 0 ... 30 secs                            | less than a minute  |
| 30 secs ... 1 min 30 secs                | 1 minute            |
| 1 min 30 secs ... 44 mins 30 secs        | [2..44] minutes     |
| 44 mins ... 30 secs ... 89 mins 30 secs  | about 1 hour        |
| 89 mins 30 secs ... 23 hrs 59 mins 30 secs | about [2..24] hours |
| 23 hrs 59 mins 30 secs ... 41 hrs 59 mins 30 secs | 1 day               |
| 41 hrs 59 mins 30 secs ... 29 days 23 hrs 59 mins 30 secs | [2..30] days        |
| 29 days 23 hrs 59 mins 30 secs ... 44 days 23 hrs 59 mins 30 secs | about 1 month       |
| 44 days 23 hrs 59 mins 30 secs ... 59 days 23 hrs 59 mins 30 secs | about 2 months      |
| 59 days 23 hrs 59 mins 30 secs ... 1 yr  | [2..12] months      |
| 1 yr ... 1 yr 3 months                   | about 1 year        |
| 1 yr 3 months ... 1 yr 9 month s         | over 1 year         |
| 1 yr 9 months ... 2 yrs                  | almost 2 years      |
| N yrs ... N yrs 3 months                 | about N years       |
| N yrs 3 months ... N yrs 9 months        | over N years        |
| N yrs 9 months ... N+1 yrs               | almost N+1 years    |


When using `includeSeconds` you'll get more precise results for distances under a minute.

| Distance between dates | Result               |
| ---------------------- | -------------------- |
| 0 secs ... 5 secs      | less than 5 seconds  |
| 5 secs ... 10 secs     | less than 10 seconds |
| 10 secs ... 20 secs    | less than 20 seconds |
| 20 secs ... 40 secs    | half a minute        |
| 40 secs ... 60 secs    | less than a minute   |
| 60 secs ... 90 secs    | 1 minute             |

This package is heavily influenced by [date-fns](https://date-fns.org/docs/distanceInWords) `distanceInWords`.
