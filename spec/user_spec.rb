require "rails_helper"

RSpec.describe User, :type => :model do
  before(:each) do 
    User.destroy_all
  end

  describe "#add" do

    it "returns error code if username is not unique" do
      opal = User.add("opalkale" , "different")
      opal2 = User.add("opalkale", "passwords")

      expect(opal2).to eq(ERR_USER_EXISTS)
    end

    it "returns error code if username > MAX_USERNAME_LENGTH" do
      opal = User.add("opalkale"*100, "different")

      expect(opal).to eq(ERR_BAD_USERNAME)
    end

    it "returns error code if password > MAX_PASSWORD_LENGTH" do
      opal = User.add("opalkale" , "different"*100)

      expect(opal).to eq(ERR_BAD_PASSWORD)
    end 

    it "returns error code if username not provided" do
      opal = User.add(nil, "different")
      opal2 = User.add("", "password")

      expect(opal).to eq(ERR_BAD_USERNAME)
      expect(opal2).to eq(ERR_BAD_USERNAME)
    end

    it "returns login count of 1 if user is successfully added to database" do
      User.add("opalkale", "different")
      opal = User.find_by(username: "opalkale" )

      expect(opal.login_count).to eq(1)
    end
    
    it "returns true if password given is empty string or nil" do
      opal = User.add("opalkale",nil)
      opal2 = User.add("opalkale2", "")

      expect(opal).to eq(SUCCESS)
      expect(opal2).to eq(SUCCESS)
    end
  end

  describe "#login" do
    
    it "returns error code if username is not provided" do
      opal = User.login(nil,"different")
      opal2 = User.login("", "password")

      expect(opal).to eq(ERR_BAD_CREDENTIALS)
      expect(opal).to eq(ERR_BAD_CREDENTIALS)
    end

    it "returns error code if username does not exist" do
      opal = User.login("opalkale","password")

      expect(opal).to eq(ERR_BAD_CREDENTIALS)
    end

    it "returns login count if user provides a correct username and password" do
      User.add("opalkale", "password")
      User.login("opalkale", "password")

      opal = User.find_by(username: "opalkale")
      expect(opal.login_count).to be > 1
    end

    it "returns error code if password is not provided" do
      opal = User.login("opalkale", nil)
      opal2 = User.login("opalkale", "")

      expect(opal).to eq(ERR_BAD_CREDENTIALS)
      expect(opal2).to eq(ERR_BAD_CREDENTIALS)

    end
  end

end