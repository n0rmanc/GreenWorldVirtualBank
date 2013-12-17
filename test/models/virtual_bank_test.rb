require 'test_helper'

class VirtualBankModelTest < ActiveSupport::TestCase

    def test_request_new_record
        actur = Bill.request_new_record(200)
        assert_equal(actur.amt, 200)
        assert_equal((Date.today + GreenWorldGateway.expire_day.to_i).strftime("%Y%m%d"), actur.expire_date.to_s)
        assert_not_nil(actur.vaccno)
        assert_not_nil(actur.bankcode)
    end

    def test_verify_record
        actur = Bill.request_new_record(200)

        payer_bank = '123'
        payer_acc = '123456789122'
        payer_amt = "#{actur.amt}"
        proc_date = "20131217"
        proc_time = "110236"
        tac = "jioerutyzndk29eiujhaMJYTFDWo9871k4rfmkdI"
        succ = "1"
        verify_result = actur.verify_record(payer_bank, payer_acc, payer_amt, proc_date, proc_time, tac, succ)

        assert_equal(payer_bank, verify_result.payer_bank)
        assert_equal(payer_acc, verify_result.payer_acc)
        assert_equal(payer_amt.to_i, verify_result.payer_amt)
        assert_equal(proc_date.to_date, verify_result.proc_date)
        assert_equal(Time.strptime(proc_time, "%H%M%S"), verify_result.proc_time)
        assert_equal(tac, verify_result.tac)
        assert_equal(succ.to_i, verify_result.succ)
    end
end
