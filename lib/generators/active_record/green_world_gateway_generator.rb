require 'rails/generators/active_record'
require 'generators/green_world_gateway/orm_helpers'


module ActiveRecord
    module Generators
        class GreenWorldGatewayGenerator < ActiveRecord::Generators::Base
            source_root File.expand_path("../templates", __FILE__)
            argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
            include GreenWorldGateway::Generators::OrmHelpers

            def copy_devise_migration
                if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
                    migration_template "migration_existing.rb", "db/migrate/add_green_world_gateway_to_#{table_name}"
                else
                    migration_template "migration.rb", "db/migrate/green_world_gateway_create_#{table_name}"
                end
            end

            def generate_model
                invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
            end

            def inject_green_world_gateway_content
                content = model_contents

                class_path = if namespaced?
                    class_name.to_s.split("::")
                else
                    [class_name]
                end

                indent_depth = class_path.size - 1
                content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"

                inject_into_class(model_path, class_path.last, content) if model_exists?
            end

            def migration_data
<<RUBY

                #request form
                t.integer :amt, :null =>  false #charge value
                #reply parameters
                t.date :expire_date          # expire_date
                t.integer :tsr                # transaction id
                t.string :bankcode              # transaction bank code
                t.string :vaccno                # transaction account

                #call back parameters
                t.integer :payer_amt            # paid money
                t.integer :succ                 # transcation status
                t.string  :payer_bank           # paid bank
                t.string  :payer_acc            # paid account
                t.date    :proc_date            # processed date
                t.time    :proc_time            # processed time
                t.string  :tac                  # transaction verify code


                ## Database authenticatable
                # t.string :email,              :null => false, :default => ""
                # t.string :encrypted_password, :null => false, :default => ""

                # ## Recoverable
                # t.string   :reset_password_token
                # t.datetime :reset_password_sent_at

                # ## Rememberable
                # t.datetime :remember_created_at

                # ## Trackable
                # t.integer  :sign_in_count, :default => 0, :null => false
                # t.datetime :current_sign_in_at
                # t.datetime :last_sign_in_at
                # t.string   :current_sign_in_ip
                # t.string   :last_sign_in_ip

                ## Confirmable
                # t.string   :confirmation_token
                # t.datetime :confirmed_at
                # t.datetime :confirmation_sent_at
                # t.string   :unconfirmed_email # Only if using reconfirmable

                ## Lockable
                # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
                # t.string   :unlock_token # Only if unlock strategy is :email or :both
                # t.datetime :locked_at
RUBY
            end



        end
    end
end