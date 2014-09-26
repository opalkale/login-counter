class TestapiController < ApplicationController
  def reset_fixture
    User.TESTAPI_resetFixture
    
    response_hash = {
        :errCode => 1 
    }
    render json: response_hash
  end

end