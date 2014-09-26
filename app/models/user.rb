# Constants
ERR_BAD_CREDENTIALS = -1
ERR_BAD_PASSWORD = -4
ERR_BAD_USERNAME = -3
ERR_USER_EXISTS = -2
MAX_PASSWORD_LENGTH = 128
MAX_USERNAME_LENGTH = 128
SUCCESS = 1

class User < ActiveRecord::Base
  
  def self.add(username, password)
    # Validate presence of username.
    if username.blank?
      return ERR_BAD_USERNAME
    end

    # Validate username <= 128 chars.
    if username.length > MAX_USERNAME_LENGTH
      return ERR_BAD_USERNAME
    end

    # Validate uniqueness of username.
    if User.find_by(username: username).present?
      return ERR_USER_EXISTS
    end

    # Validate password length is <= 128 chars.
    if password.present? && password.length > MAX_PASSWORD_LENGTH
      return ERR_BAD_PASSWORD
    end

    # Returns ERR_BAD_USERNAME for combination of length of username > 128 and length of password > 128.
    if username.length > MAX_USERNAME_LENGTH && password.length > MAX_PASSWORD_LENGTH
      return ERR_BAD_USERNAME
    end

    # Returns ERR_BAD_USERNAME for combination of existing username and password > 128. 
    if User.find_by(username: username).present? && password > MAX_PASSWORD_LENGTH
      return ERR_BAD_USERNAME
    end

    # Creates a user in the database with username and password specified. 
    # Login count is initialized to 1.
    current_user = User.create(:username => username, :password => password, :login_count => 1)
    current_user_login_count = current_user.login_count
    
    # Returns the login count for the current user.
    return current_user_login_count
  
  end

  def self.login(username, password)
    
    # Finds a user object given the username.
    current_user = User.find_by(username: username)

    # Validates that the username exists.
    if current_user.nil?
      return ERR_BAD_CREDENTIALS
    
    # Validates the password for the given username, increments, saves, and returns the login count.
    elsif password == current_user.password

      current_user.login_count += 1
      current_user.save
      return current_user.login_count
    
    else
      return ERR_BAD_CREDENTIALS
    end
  end

  def self.TESTAPI_resetFixture
    User.destroy_all
    SUCCESS
  end

end