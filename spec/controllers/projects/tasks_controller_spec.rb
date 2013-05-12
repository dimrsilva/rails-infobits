require 'spec_helper'

describe Projects::TasksController do

  let :project do
    FactoryGirl.create('projects/project')
  end

  let(:row) do
    FactoryGirl.create('projects/task')
  end

  it_behaves_like "Crud resource", Projects::Task do
    let(:get_index_action) { nil }
    let(:get_new_action) { {:action => :new, :projects_project_id => project.id} }
    let(:get_edit_action) { {:action => :edit, :id => row.id, :projects_project_id => project.id} }
    let(:get_show_action) { nil }
    let(:post_create_action) { {:action => :create, :projects_project_id => project.id} }
    let(:put_update_action) { {:action => :update, :id => row.id, :projects_project_id => project.id} }
    let(:delete_destroy_action) { {:action => :destroy, :id => row.id, :projects_project_id => project.id} }
  end

  it_behaves_like "Authenticated resource" do
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

        get :new, :projects_project_id => project.id
        assigns[:colaborators].should eql [c1,c2]
      end

      context "without render views" do
        render_views false
        it "should batch update items" do
          p = FactoryGirl.create('projects/project')
          t1 = FactoryGirl.create('projects/task', :project => p)
          t2 = FactoryGirl.create('projects/task', :project => p)
          t3 = FactoryGirl.create('projects/task', :project => p)
          data = [
            ["0", {:id => t2.id.to_s, :parent_id => t1.id.to_s}],
            ["1", {:id => t3.id.to_s, :parent_id => t1.id.to_s}]
          ]
          post :batch_update, :id => t2.id, :projects_project_id => p.id, :projects_tasks => data
          response.should be_success
          t1.children_tasks.count.should eql 2
        end
      end
    end
  end
end
