$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'spinal'

require 'rspec/core'

require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each do |support_file|
  require File.expand_path(support_file)
end
