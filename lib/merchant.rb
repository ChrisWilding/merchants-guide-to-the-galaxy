require 'merchant/converters/roman_to_arabic_converter'
require 'merchant/models/commodity'
require 'merchant/version'

%w(parsers services).each do |dir|
  Dir["#{File.dirname(__FILE__)}/merchant/#{dir}/*.rb"].each { |file| require file }
end
