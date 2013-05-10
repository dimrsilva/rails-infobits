require 'spec_helper'

describe Contacts::PeopleController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource default behavior", Contact::Person

  context "User is authenticated" do
    before :each do
      sign_in_administrator
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
