require 'spec_helper'

describe Contacts::GroupsController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource"

  context "User is authenticated" do
    before :each do
      sign_in_administrator
    end

    it "should show error when deleting group with contacts" do
      @group = Contact::Group.new
      @group.save
      @contact = FactoryGirl.create("contact/contact")
      @contact.groups << @group
      @contact.save

      post :destroy, :id => @group.id
      flash[:alert].should_not be_empty
    end
  end
end
