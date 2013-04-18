require 'spec_helper'

describe Contacts::GroupsController do
  it_behaves_like CrudController

  context "User is authenticated" do
    before :each do
      Admin::User.any_instance.stub(:valid?).and_return(true)
      @user = Admin::User.create :email => "test@example.com"
      sign_in @user
    end

    it "should show error when deleting group with contacts" do
      @group = Contact::Group.new
      @group.save
      @contact = FactoryGirl.create("contact/contact")
      @contact.groups << @group
      @contact.save

      post :destroy, :id => @group.id
      response.should redirect_to contact_groups_path
    end
  end
end
