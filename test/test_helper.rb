ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rails/test_help'

require 'minitest/spec'

Minitest::Reporters.use!([
  Minitest::Reporters::DefaultReporter.new
])
