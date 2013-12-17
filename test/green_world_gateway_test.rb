require 'test_helper'

class GreenWorldGatewayTest <  ActiveSupport::TestCase
    test "truth" do
        assert_kind_of Module, GreenWorldGateway
    end

    def test_verify_receive_callback
        assert_equal(false, GreenWorldGateway.verify_receive_callback(GreenWorldGateway.enc_key, '20090101', '170105', '11', 'asdfjlqkwruio234lkjSADSF'))
    end
end
