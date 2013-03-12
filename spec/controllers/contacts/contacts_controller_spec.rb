require 'spec_helper'

describe Contacts::ContactsController do

  context "User is not authenticated" do
    it "should require authentication" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context "User is authenticated" do
    before :each do
      @user = Admin::User.create :email => "test@gmail.com", :password => "12345678",
        :password_confirmation => "12345678"
      sign_in @user
    end

    it "should not redirect to authentication page" do
      get :index
      response.should_not redirect_to new_user_session_path
    end
  end

end
