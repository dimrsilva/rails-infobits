require 'spec_helper'

describe "The signup process", :type => :feature do
  before :each do
    Admin::User.create(:email => 'user@example.com', :password => 'test')
  end

  it "signs me in" do
    visit '/'
    within("form") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'test'
    end
    click_button 'Sign in'

    page.should have_content 'Signed in as'
  end
end