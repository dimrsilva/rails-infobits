require 'spec_helper'

describe "Accessing Contacts", :type => :feature do
  before :each do
    Admin::User.any_instance.stub(:valid?).and_return(true)
    @user = Admin::User.create :email => "test@example.com"
    sign_in @user
  end

  context "as administrator" do
    it "should show contacts list" do
      visit '/'
      page.should have_content 'Contacts'
    end

  end

end