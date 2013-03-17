require 'spec_helper'

describe Admin::User do

  before :each do
    @user = Admin::User.new
  end

  it "should validate email" do
    @user.email = 'dfdjsf@jfsk@#'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email)
    @user.email = 'test@example.com'
    @user.should be_valid
  end

  it "should have unique emails" do
    Admin::User.create email: 'a@b.com', password: '1', password_confirmation: '1'
    @user.email = 'a@b.com'
    @user.password = '2'
    @user.password_confirmation = '2'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email)
  end

  it "should confirm password" do
    @user.password = 'test'
    @user.password_confirmation = ''
    @user.should_not be_valid
    @user.should have(1).errors_on(:password)

    @user.password = 'test'
    @user.password_confirmation = 'test'
    @user.should_not be_valid #cause is missing email
    @user.should have(:no).errors_on(:password)
  end

  it "should require email field" do
    @user.should_not be_valid
    @user.should have(1).errors_on(:email) #required
    @user.email = 'invalid email'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email) #invalid email
  end

  it "should not update password if empty string is passed" do
    @user.email = 'test@example.com'
    @user.password = '123'
    @user.password_confirmation = '123'
    @user.should be_valid
    @user.save
    id = @user.id
    encrypted = @user.encrypted_password
    @user.password = ''
    @user.password_confirmation = '';
    @user.save
    @user = Admin::User.find id
    @user.encrypted_password.should eql encrypted
  end
end
