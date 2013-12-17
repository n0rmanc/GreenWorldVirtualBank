module GreenWorldGateway
    module VirtualBank
        def self.get_request_url(od_sob = nil, amt = 0, expire_day = 0)
            "https://ecbank.com.tw/gateway.php?mer_id=#{GreenWorldGateway.mer_id}&payment_type=vacc&setbank=#{GreenWorldGateway.setbank}&enc_key=#{GreenWorldGateway.enc_key}&od_sob=#{od_sob}&amt=#{amt}&expire_day=#{expire_day}&ok_url=#{call_back_url}"
        end

        def self.request(od_sob = nil, amt = 0, expire_day = 0)
            request_url = get_request_url(od_sob, amt, expire_day)
            body =  Net::HTTP.get(URI.parse(request_url))
            result = RequestResult.new
            result_strings = body.split('&')
            if("error=0".eql?(result_strings[0]))
                result_strings.each do |result_string|
                split_string = result_string.split('=')
                result.instance_variable_set("@#{split_string[0]}", split_string[1])
                end
            else
                logger.debug
            end
            return result body
        end

        def self.call_back_url
            "http://#{Socket.gethostname}/green_world_gateway/virtual_bank/callback"
        end

        class RequestResult
            attr_accessor :error
            attr_accessor :mer_id
            attr_accessor :tsr
            attr_accessor :od_sob
            attr_accessor :bankcode
            attr_accessor :vaccno
            attr_accessor :amt
            attr_accessor :expire_date
        end
    end
end
