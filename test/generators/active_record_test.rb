require "test_helper"

# if DEVISE_ORM == :active_record
require "generators/active_record/green_world_gateway_generator"

class ActiveRecordGeneratorTest < Rails::Generators::TestCase
    tests ActiveRecord::Generators::GreenWorldGatewayGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination

    test "all files are properly created with rails31 migration syntax" do
      run_generator %w(monster)
      assert_migration "db/migrate/green_world_gateway_create_monsters.rb", /def change/
  end
end