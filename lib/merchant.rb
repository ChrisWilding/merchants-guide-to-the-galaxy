require 'merchant/converters/roman_to_arabic_converter'
require 'merchant/models/commodity'
require 'merchant/version'

Dir[File.dirname(__FILE__) + '/merchant/parsers/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/merchant/services/*.rb'].each { |file| require file }

module Merchant
  # Your code goes here...
end
