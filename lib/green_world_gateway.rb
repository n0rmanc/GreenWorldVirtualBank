require 'rails/generators/base'
require 'green_world_gateway/models/virtual_bank'
require 'green_world_gateway/virtual_bank'
require 'socket'
module GreenWorldGateway

    autoload :VirtualBank,          'green_world_gateway/virtual_bank'

    mattr_accessor :mer_id
    mattr_accessor :setbank
    mattr_accessor :enc_key
    mattr_accessor :expire_day
    # Default way to setup Devise. Run rails generate devise_install to create
    # a fresh initializer with all configuration values.
    def self.setup
        yield self
    end

    def self.verify_receive_callback(key, proc_date, proc_time, tsr, tac)
        serial = proc_date + proc_time + tsr.to_s
        url = "https://ecbank.com.tw/web_service/get_outmac_valid.php?key=#{key}&serial=#{serial}&tac=#{tac}"
        body =  Net::HTTP.get(URI.parse(url))
        if 'valid=0'.eql?(body)
            return false
        else
            return true
        end
    end
end
