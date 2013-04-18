require 'spec_helper'

describe Projects::ProjectsController do
  it_behaves_like CrudController

  context "User is authenticated" do
    before :each do
      Admin::User.any_instance.stub(:valid?).and_return(true)
      @user = Admin::User.create :email => "test@example.com"
      sign_in @user
    end

    it "should convert manager string to object" do
      @project = Projects::Project.new
      @project.stub!(:id).and_return(1)
      @project.stub!(:save)
      Projects::Project.stub!(:find).with(1).and_return(@project)
      @person = Contact::Person.new
      @person.stub!(:id).and_return(5)
      Contact::Person.stub!(:find).with(5).and_return(@person)

      post :update, :id => @project.id, :projects_project => { :manager => @person.to_s }
      controller.params[:projects_project][:manager].should eql @person
    end

    it "should convert manager string to nil, when invalid string is sent" do
      @project = Projects::Project.new
      @project.stub!(:id).and_return(1)
      @project.stub!(:save)
      Projects::Project.stub!(:find).with(1).and_return(@project)

      post :update, :id => @project.id, :projects_project => { :manager => '' }
      controller.params[:projects_project][:manager].should eql nil
    end
  end
end
