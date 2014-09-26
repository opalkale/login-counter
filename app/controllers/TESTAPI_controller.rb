class TestapiController < ApplicationController
  def reset_fixture
    User.TESTAPI_resetFixture
    
    response_hash = {
        :errCode => 1 
    }
    render json: response_hash
  end

  def unit_tests
    result = %x[rspec]
    total_tests = result.split(" examples")[0].split("\n")[-1].to_i
    failed_tests = result.split(" failures")[0].split(", ")][-1].to_i
    
    response_hash = {
      nrFailed: failed_tests,
      output: result,
      totalTests: total_tests,
    }

    render json: response_hash
  end
end