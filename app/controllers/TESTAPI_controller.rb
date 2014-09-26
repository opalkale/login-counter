class TestapiController < ApplicationController
  def reset_fixture
    User.TESTAPI_resetFixture
    
    response_hash = {
        :errCode => 1 
    }
    render json: response_hash
  end

  def unit_tests
    exec "rspec"
    response_hash = {
      nrFailed: 0,
      output: "",
      totalTests: 5,
    }

    render json: response_hash
  end
end