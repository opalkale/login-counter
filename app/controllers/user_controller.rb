class UserController < ApplicationController
  
  def home
  end

  def authenticate

    @username = params[:username]
    @password = params[:password]
    puts params[:button]

    # Logging in.
    if params[:button] == "Login" 
      @result = User.login(@username, @password)
      # Successful outcome.
      if @result >= 0
        user = User.find_by(username: @username)
        @login_num = user.login_count

      # The result is the error message in failure cases.
      # The error message is found in the LOOKUP_TABLE in the User Model.
      else
        flash[:notice] = ERROR_LOOKUP[@result]
        redirect_to home_path
      end
    end

    # Adding a user.
    if params[:button] == "Add User"

      @result = User.add(@username, @password)

      # Succesful outcome.
      if @result >= 0
        user = User.find_by(username: @username)
        @login_num = user.login_count

     # The result is the error message in failure cases.
     # The error message is found in the ERROR_LOOKUP in the User Model.
      else
        flash[:notice] = ERROR_LOOKUP[@result]
        redirect_to home_path
      end

    end
  end

  def logout
    redirect_to home_path
  end

end
