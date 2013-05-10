require 'spec_helper'

describe Projects::ProjectsController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource default behavior", Projects::Project

  context "User is authenticated" do
    before :each do
      sign_in_administrator
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

    it "should see only contacts of groups marked as acts_as_colaborator on checkbox of colaborators" do
      @project = FactoryGirl.create('projects/project')

      @valid_group = FactoryGirl.create('contact/group', :acts_as_colaborator => true)
      @invalid_group = FactoryGirl.create('contact/group', :acts_as_colaborator => false)

      @c1 = FactoryGirl.create('contact/person')
      @c1.groups << @valid_group
      @c1.groups << @invalid_group
      @c1.save

      @c2 = FactoryGirl.create('contact/person')
      @c2.groups << @valid_group
      @c2.save

      @c3 = FactoryGirl.create('contact/person')
      @c3.groups << @invalid_group
      @c3.save

      get :edit, :id => @project.id
      assigns[:colaborators].should eql [@c1, @c2]
    end

    it "should not show contact twice when he is in two groups which acts_as_colaborator" do
      @project = FactoryGirl.create('projects/project')

      @valid_group = FactoryGirl.create('contact/group', :acts_as_colaborator => true)
      @valid_group2 = FactoryGirl.create('contact/group', :acts_as_colaborator => true)

      @c1 = FactoryGirl.create('contact/person')
      @c1.groups << @valid_group
      @c1.groups << @valid_group2
      @c1.save

      @c2 = FactoryGirl.create('contact/person')
      @c2.groups << @valid_group
      @c2.save

      @c3 = FactoryGirl.create('contact/person')

      get :edit, :id => @project.id
      assigns[:colaborators].should eql [@c1, @c2]
    end
  end
end
