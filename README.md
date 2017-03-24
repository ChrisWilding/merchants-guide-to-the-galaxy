# Merchant's Guide to the Galaxy

## Setup

Install ruby 2.4.0 using your ruby version manager of choice. Install the dependencies -
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

There is a service object to represent handling each kind of input statement of
question. Each service delegates to a parser to work out if it can handle a
question or statement and to parse the input. The service objects store and
process the result of parsing the input and where appropriate provide methods
for other services to query that parsed information.

The commodity model uses BigDecimal for currency calculations to avoid any
floating point rounding errors. When displayed the big decimals are cast to
integers which may result in data loss. Further requirements to understand how
fractional galactic credits are represent would be required to improve the handling here.

Roman numeral to arabic conversions do not require any knowledge of galactic
trade so could be extracted out to a separate module or gem but for convenience
has been kept in this gem as a converter class.

