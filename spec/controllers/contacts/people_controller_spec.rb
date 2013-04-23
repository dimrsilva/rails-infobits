require 'spec_helper'

describe Contacts::PeopleController do
  it_behaves_like CrudController

  context "User is authenticated" do
    before :each do
      Admin::User.any_instance.stub(:valid?).and_return(true)
      @user = Admin::User.create :email => "test@example.com"
      sign_in @user
    end

    it "should show error when deleting person registered as representant of an company" do
      @person = FactoryGirl.create("contact/person")
      @company = FactoryGirl.create("contact/company")
      @company.representant = @person
      @company.save

      post :destroy, :id => @person.id
      flash[:alert].should_not be_empty
    end
  end
end
