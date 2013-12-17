# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

# For generators
require "rails/generators/test_case"
require "generators/green_world_gateway/install_generator"

# For get host name
require 'socket'

module GreenWorldGateway
    self.mer_id = '1234'
    self.setbank = 'ESUN'
    self.enc_key = 'ermfaoweir38dfaSAf'
    self.expire_day = '20'
end

@@od_sob = 0
@@amt = 400
@@expire_day = 20