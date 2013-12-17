require 'rails/generators/named_base'

module GreenWorldGateway
    module Generators
        class GreenWorldGatewayGenerator < Rails::Generators::NamedBase
            include Rails::Generators::ResourceHelpers

            namespace "green_world_gateway"

            hook_for :orm

            source_root File.expand_path("../templates", __FILE__)
            def add_virtual_bank_route
                route "post 'green_world_gateway/:action/callback', to: 'green_world_gateway#:action', as: 'green_world_gateway_callback'"
            end
        end
    end
end



