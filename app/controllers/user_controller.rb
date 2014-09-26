class UserController < ApplicationController
  def add
    response_hash = {}

    username = params[:user]
    password = params[:password]
    result = User.add(username, password)

    # Successful outcome.
    if result >= 0
      response_hash[:errCode] = SUCCESS

      user = User.find_by(username: username)
      response_hash[:count] = user.login_count
    else
      # The result is the error code in failure cases.
      response_hash[:errCode] = result
    end

    render json: response_hash
  end

  def login
    response_hash = {}

    username = params[:user]
    password = params[:password]
    result = User.login(username, password)

    # Successful outcome.
    if result >= 0
      response_hash[:errCode] = SUCCESS

      user = User.find_by(username: username)
      response_hash[:count] = user.login_count
    else
      # The result is the error code in failure cases.
      response_hash[:errCode] = result
    end

    render json: response_hash
  end

end