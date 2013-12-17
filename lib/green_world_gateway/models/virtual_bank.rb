module GreenWorldGateway
    module Models
        module VirtualBank
            module ClassMethods
                def request_new_record(amt)
                    self.transaction do
                        new_record = self.new
                        new_record.amt = amt
                        new_record.save!
                        result = GreenWorldGateway::VirtualBank.request(new_record.id, amt, GreenWorldGateway.expire_day)
                        if(result && result.error.to_i == 0 &&
                            GreenWorldGateway.mer_id.eql?(result.mer_id) &&
                            amt.to_s.eql?(result.amt) &&
                            result.od_sob.to_i == new_record.id)
                            new_record.tsr = result.tsr
                            new_record.bankcode = result.bankcode
                            new_record.vaccno   =result.vaccno
                            new_record.expire_date = result.expire_date
                            new_record.save!
                        else
                            raise ActiveRecord::Rollback, "Virtual Bank request_new_record error"
                        end
                    end
                    return self.last
                end
            end

            module InstanceMethods
                def verify_record(payer_bank, payer_acc, payer_amt, proc_date, proc_time, tac, succ)
                    verify_result = GreenWorldGateway.verify_receive_callback(GreenWorldGateway.enc_key, proc_date, proc_time, self.tsr , tac)
                    if(verify_result)
                        self.payer_bank = payer_bank
                        self.payer_acc = payer_acc
                        self.payer_amt = payer_amt
                        self.proc_date = proc_date
                        self.proc_time = Time.strptime(proc_time, "%H%M%S")
                        self.tac = tac
                        self.succ = succ
                        self.save!
                        return self
                    else
                        logger.debug verify_result
                    end
                end
            end

            def self.included(receiver)
                receiver.extend         ClassMethods
                receiver.send :include, InstanceMethods
            end
        end
    end
end