require 'test_helper'
require 'net/http'
# require 'green_world_gateway/virtual_bank'

class VirtualBankTest < ActionController::TestCase

    def test_get_request_url
        answer = "https://ecbank.com.tw/gateway.php?mer_id=#{GreenWorldGateway.mer_id}&payment_type=vacc&setbank=#{GreenWorldGateway.setbank}&enc_key=#{GreenWorldGateway.enc_key}&od_sob=#{@@od_sob}&amt=#{@@amt}&expire_day=#{GreenWorldGateway.expire_day}&ok_url=#{GreenWorldGateway::VirtualBank.call_back_url}"
        assert_equal(answer, GreenWorldGateway::VirtualBank.get_request_url(@@od_sob, @@amt, GreenWorldGateway.expire_day), "virtual bank get wrong url")
    end

    def test_request
        result = GreenWorldGateway::VirtualBank.request(@@od_sob, @@amt, GreenWorldGateway.expire_day)

        assert_equal('0', result.error, "no error")
        assert_equal('5887', result.mer_id, "no mer_id")
        assert_equal(@@od_sob.to_s, result.od_sob, "no od_sob")
        assert_equal('808', result.bankcode, "no backcode")
        assert_equal(@@amt.to_s, result.amt, "no amt")

        # t.to_s                              => "2012-11-10 18:16:12 +0100"
        # t.strftime "%Y-%m-%d %H:%M:%S %z"   => "2012-11-10 18:16:12 +0100"

        # t.utc.to_s                          => "2012-11-10 17:16:12 UTC"
        # t.strftime "%Y-%m-%d %H:%M:%S UTC"  => "2012-11-10 17:16:12 UTC"
        assert_equal((Date.today + 20 ).strftime("%Y%m%d"), result.expire_date)
    end

    def test_get_ok_url
        virtual_bank_back_path = @routes.url_helpers.send(:green_world_gateway_callback_path, :virtual_bank)
        assert_equal( "http://#{Socket.gethostname}#{virtual_bank_back_path}" , GreenWorldGateway::VirtualBank.call_back_url)
    end
end
