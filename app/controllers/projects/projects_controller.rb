class Projects::ProjectsController < ApplicationController
  include Core::CrudResource

  def show
    @task_statuses_count = Projects::TaskStatus.count
    @task_statuses = Projects::TaskStatus.order(:percent).all
    super
  end

  def new
    @row.manager = current_user.contact
    super
  end

  protected
    def fill_aditional_fixture
      @row.fixtures.build
    end

    def get_model
      Projects::Project
    end

    def load_table_list_columns
      @table_list_columns = [:id, :title, :tasks]
    end

    def process_form
      super
      @colaborators = Contact::Contact.joins(:groups).where('acts_as_colaborator = 1').group(:id).all
      fill_aditional_fixture
    end

    def load_show_actions
      super
      if can? :create, Projects::Task
        @action_buttons << {
          :text => I18n.t('helpers.link.create', :model => Projects::Task.model_name.human),
          :url => new_projects_project_projects_task_url(:projects_project_id => @row.id)
        }
      end
    end
end
