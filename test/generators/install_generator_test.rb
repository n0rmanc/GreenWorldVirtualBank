require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
    tests GreenWorld::InstallGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination

    test "Assert all files are properly created" do
        run_generator
        assert_file "app/controllers/green_world_gateway_controller.rb"
        assert_file "config/initializers/green_world.rb"
    end

end
