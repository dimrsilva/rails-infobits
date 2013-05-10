class Projects::ProjectsController < ApplicationController
  include Core::CrudResource

  protected
    def get_model
      Projects::Project
    end

    def process_form
      super
      @colaborators = Contact::Contact.joins(:groups).where('acts_as_colaborator = 1').group(:id).all
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
