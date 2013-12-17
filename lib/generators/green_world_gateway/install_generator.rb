module GreenWorld
  class InstallGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)
    def copy_locale
      copy_file "config/initializers/green_world.rb", "config/initializers/green_world.rb"
    end

    def copy_controller
        copy_file "app/controllers/green_world_gateway_controller.rb", "app/controllers/green_world_gateway_controller.rb"
    end
  end
end
