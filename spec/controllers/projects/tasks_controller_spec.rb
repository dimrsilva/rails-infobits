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
      @model = controller.send(:get_model)
      @user = FactoryGirl.create('admin/user')
      sign_in @user
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
    end
  end
end
