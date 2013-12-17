require 'test_helper'

# ExpectedRoutingError = Devise.rails4? ? MiniTest::Assertion : ActionController::RoutingError

class DefaultRoutingTest < ActionController::TestCase
    def test_ok_rul_receive_session
        assert_recognizes({:controller => 'green_world_gateway', :action => 'virtual_bank'}, {:path => 'green_world_gateway/virtual_bank/callback', :method => :post})
        assert_named_route "/green_world_gateway/virtual_bank/callback", :green_world_gateway_callback_path, :virtual_bank
    end

    protected

    def assert_named_route(result, *args)
        assert_equal result, @routes.url_helpers.send(*args)
    end
end