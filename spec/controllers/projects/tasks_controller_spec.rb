require 'spec_helper'

describe Projects::TasksController do

  let :project do
    FactoryGirl.create('projects/project')
  end

  let(:row) do
    FactoryGirl.create(controller.send(:get_model).model_name.underscore, :project => project)
  end

  context "Authenticated resource" do
    include_examples "Authenticated resource"
    let :get_example do
      get :new, :projects_project_id => project.id
    end
  end

  context "User is Authenticated" do

    before :each do
      sign_in_administrator
    end

    context "with valid data" do
      it "should redirect to project view after update" do
        post :update, :id => row.id, :projects_project_id => project.id
        response.should redirect_to project
      end
      it "should redirect to project view after destroy" do
        post :destroy, :id => row.id, :projects_project_id => project.id
        response.should redirect_to project
      end
      it "should redirect to project view after destroy with referer" do
        @request.env['HTTP_REFERER'] = edit_projects_project_projects_task_url row.id, :projects_project_id => project.id
        post :destroy, :id => row.id, :projects_project_id => project.id
        response.should redirect_to project
      end
      it "should redirect to project view after insert" do
        post :create, :projects_project_id => project.id
        response.should redirect_to project
      end
      it "should show on select box only contacts in project" do
        c1 = FactoryGirl.create('contact/contact')
        c2 = FactoryGirl.create('contact/contact')
        c3 = FactoryGirl.create('contact/contact')
        project.colaborators << c1
        project.colaborators << c2
        project.colaborators << c3

        get :new, :projects_project_id => project.id
        assigns[:colaborators].should eql [c1,c2,c3]
      end
    end
  end
end
