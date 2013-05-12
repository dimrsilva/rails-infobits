require 'spec_helper'

describe Projects::ProjectsController do
  it_behaves_like "Authenticated resource"
  it_behaves_like "Paginated resource"
  it_behaves_like "Crud resource default behavior", Projects::Project do
    context "with tasks" do
      it "should be success on index when has tasks" do
        task = FactoryGirl.create('projects/task')
        get :index
        response.should be_success
      end
    end
  end

  context "User is authenticated" do
    before :each do
      sign_in_administrator
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
      assigns[:colaborators].all.should eql [@c1, @c2]
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
      assigns[:colaborators].all.should eql [@c1, @c2]
    end
  end
end
