require 'spec_helper'

describe Contacts::CompaniesController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource default behavior", Contact::Company

  context "User is authenticated" do
    before :each do
      Admin::User.any_instance.stub(:valid?).and_return(true)
      @user = Admin::User.create :email => "test@example.com"
      sign_in @user
    end

    it "should convert representant string to id" do
      @company = Contact::Company.new
      @company.stub!(:id).and_return(1)
      Contact::Company.stub!(:find).with(1).and_return(@company)
      @person = Contact::Person.new
      @person.stub!(:id).and_return(5)
      Contact::Person.stub!(:find).with(5).and_return(@person)

      post :update, :id => @company.id, :contact_company => { :representant => @person.to_s }
      controller.params[:contact_company][:representant].should eql @person
    end
  end
end
