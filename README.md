# Merchant's Guide to the Galaxy

You decided to give up on earth after the latest financial collapse left 99.99%
of the earth's population with 0.01% of the wealth. Luckily, with the scant sum
of money that is left in your account, you are able to afford to rent a
spaceship, leave earth, and fly all over the galaxy to sell common metals and
dirt (which apparently is worth a lot).

Buying and selling over the galaxy requires you to convert numbers and units,
and you decided to write a program to help you.

The numbers used for intergalactic transactions follows similar convention to
the roman numerals and you have painstakingly collected the appropriate
translation between them.

Roman numerals are based on seven symbols:

| Symbol | Value |
|--------|-------|
| I      | 1     |
| V      | 5     |
| X      | 10    |
| L      | 50    |
| C      | 100   |
| D      | 500   |
| M      | 1,000 |

Numbers are formed by combining symbols together and adding the values. For
example, MMVI is 1000 + 1000 + 5 + 1 = 2006. Generally, symbols are placed in
order of value, starting with the largest values. When smaller values precede
larger values, the smaller values are subtracted from the larger values, and
the result is added to the total. For example MCMXLIV = 1000 + (1000 - 100) +
(50 - 10) + (5 - 1) = 1944.

* The symbols "I", "X", "C", and "M" can be repeated three times in succession,
  but no more. (They may appear four times if the third and fourth are
  separated by a smaller value, such as XXXIX.) "D", "L", and "V" can never be
  repeated.

* "I" can be subtracted from "V" and "X" only. "X" can be subtracted from "L"
  and "C" only. "C" can be subtracted from "D" and "M" only. "V", "L", and "D"
  can never be subtracted.

* Only one small-value symbol may be subtracted from any large-value symbol.

* A number written in Arabic numerals can be broken into digits. For example,
  1903 is composed of 1, 9, 0, and 3. To write the Roman numeral, each of the
  non-zero digits should be treated separately. In the above example, 1,000 =
  M, 900 = CM, and 3 = III. Therefore, 1903 = MCMIII.

(Source: Wikipedia http://en.wikipedia.org/wiki/Roman_numerals)

Input to your program consists of lines of text detailing your notes on the
conversion between intergalactic units and roman numerals.

You are expected to handle invalid queries appropriately.

Test input:
```
glob is I
prok is V
pish is X
tegj is L
glob glob Silver is 34 Credits
glob prok Gold is 57800 Credits
pish pish Iron is 3910 Credits
how much is pish tegj glob glob ?
how many Credits is glob prok Silver ?
how many Credits is glob prok Gold ?
how many Credits is glob prok Iron ?
how much wood could a woodchuck chuck if a woodchuck could chuck wood ?
```

Test Output:
```
pish tegj glob glob is 42
glob prok Silver is 68 Credits
glob prok Gold is 57800 Credits
glob prok Iron is 782 Credits
I have no idea what you are talking about
```


## Setup

Install ruby 2.5.0 using your ruby version manager of choice. Install the dependencies -
```sh
$ bundle install
```

## Testing

To run the specs and rubocop run -
```sh
bundle exec rake
```

## Running

To run -
```sh
bin/merchant ./path/to/input.txt
```

With the example input
```sh
bin/merchant ./fixtures/input.txt
```

# Assumptions
"M" can be only be repeated three times in succession as such the highest roman
numeral accepted as valid is 3999. I've assumed that the application will only
accept input in the standard subtractive form.

I've assumed that although the sample input only provides translation up to
roman numeral L that in the future C, D and M may be provided and handled this
appropriately.

As there are a limited number of roman numerals the numerals 1-3999 are
pre-calculated. Validation is then completed as a simple lookup where if the
numeral is not present in the pre-calculated hash then it is considered
invalid.

# Design
The CLI class takes responsibility for dealing external environment
* it checks and parses ARGV
* it reads and preprocessing the input before passing on to the GalacticTrade class

The GalacticTrade class is responsible for setting up the service objects and
processing the inputs

Individual line parser object have now been combined into a single parser that uses
the standard library string scanner. Advantage is that all parser rules are in a
single well defined place. However, this may become too complex with many things to
parse. An unknown definition or query statement in the input is now generated as a node
in the output from the parser.

There is a service object to represent handling each kind of input statement of
question. Each service inspects the node type to decide if it can handle it
The service objects store and process the result of parsing the input and
where appropriate provide methods for other services to query that parsed information.

The commodity model uses BigDecimal for currency calculations to avoid any
floating point rounding errors. When displayed the big decimals are cast to
integers which may result in data loss. Further requirements to understand how
fractional galactic credits are represent would be required to improve the handling here.

Roman numeral to arabic conversions do not require any knowledge of galactic
trade so could be extracted out to a separate module or gem but for convenience
has been kept in this gem as a converter class.
