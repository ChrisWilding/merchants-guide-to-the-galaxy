require 'strscan'

module Merchant
  class Parser
    NEWLINE = /\n/
    NEWLINE_OR_EOS = /#{NEWLINE}|$/
    PRICE_DEFINITION = /^.* is \d+ Credits$/
    PRICE_QUERY = /^how many Credits is .* \?$/
    ROMAN = /I|V|X|L|C|D|M/
    IS = / is /
    TRANSLATION_DEFINITION = /^\w+ is #{ROMAN}$/
    TRANSLATION_QUERY = /^how much is .* \?$/

    MAPPING = {
      parse_price_definition: PRICE_DEFINITION,
      parse_price_query: PRICE_QUERY,
      parse_translation_definition: TRANSLATION_DEFINITION,
      parse_translation_query: TRANSLATION_QUERY
    }.freeze

    attr_reader :ast

    def initialize(input)
      @scanner = StringScanner.new(input)
      @ast = []
    end

    def parse
      default = -> { :parse_unknown_definition_or_query }
      until scanner.eos?
        method, = MAPPING.find(default) do |_, regexp|
          scanner.match?(regexp)
        end
        send(method)
      end
      ast
    end

    private

    attr_reader :scanner

    def parse_translation_definition
      galactic = scanner.scan_until(IS).chomp(IS.source)
      roman = scanner.scan(ROMAN).strip
      ast << TranslationDefinition.new(galactic, roman)
      scanner.skip_until(NEWLINE_OR_EOS)
    end

    def parse_price_definition
      *galactic, commodity = scanner.scan_until(IS).chomp(IS.source).split
      credits = scanner.scan(/\d+/)
      ast << PriceDefinition.new(galactic.join(' '), commodity, credits)
      scanner.skip_until(NEWLINE_OR_EOS)
    end

    def parse_translation_query
      scanner.skip(/how much is /)
      galactic = scanner.scan_until(/\?/).chomp('?').strip
      ast << TranslationQuery.new(galactic)
      scanner.skip_until(NEWLINE_OR_EOS)
    end

    def parse_price_query
      scanner.skip(/how many Credits is /)
      *galactic, commodity = scanner.scan_until(/\?/).chomp('?').split
      ast << PriceQuery.new(galactic.join(' '), commodity)
      scanner.skip(NEWLINE_OR_EOS)
    end

    def parse_unknown_definition_or_query
      scanner.skip_until(NEWLINE_OR_EOS)
      ast << UnknownDefinitionOrQuery.new
    end
  end
end
