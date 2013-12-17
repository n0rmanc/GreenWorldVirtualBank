require 'test_helper'
require 'generators/green_world_gateway/templates/app/controllers/green_world_gateway_controller'

class GreenWorldGatewayControllerTest < ActionController::TestCase


    # def test_receive_request
    #     actur = Bill.request_new_record(200)

    #     post(:virtual_bank, {'mer_id' => GreenWorldGateway.mer_id, 'payment_type' => 'vacc', 'tsr' => "#{actur.tsr}", 'od_sob' => "#{actur.id}",
    #        'amt' => "#{actur.amt}", 'payer_amt' => '190', 'expire_date' => "#{actur.expire_date}", 'succ' => '1', 'payer_bank' => '822', 'payer_acc' => '65566',
    #        'proc_date' => '20140101', 'proc_time' => '171836', 'tac' => 'ASerasfjklasf897rkjhwerknakjfyu', 'trigger' => 'true'})
    #     result = actur.verify_record
    #     puts result

    #             # #request form
    #             # t.integer :amt, :null =>  false #charge value
    #             # #reply parameters
    #             # t.date :expire_date          # expire_date
    #             # t.integer :tsr                # transaction id
    #             # t.string :bankcode              # transaction bank code
    #             # t.string :vaccno                # transaction account

    #             # #call back parameters
    #             # t.integer :payer_amt            # paid money
    #             # t.integer :succ                 # transcation status
    #             # t.string  :payer_bank           # paid bank
    #             # t.string  :payer_acc            # paid account
    #             # t.date    :proc_date            # processed date
    #             # t.time    :proc_time            # processed time
    #             # t.string  :tac                  # transaction verify code

    #     assert_response :success
    #     assert_not_nil assigns(:posts)
    # end
end