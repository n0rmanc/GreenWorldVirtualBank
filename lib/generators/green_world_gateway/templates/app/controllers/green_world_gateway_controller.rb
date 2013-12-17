class GreenWorldGatewayController < ActionController::Base

    def virtual_bank
        valid = 0
        if(valid == 0)
            render text: "error"
        else
            render text: "ok"
        end
    end
end