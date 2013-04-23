class Projects::ProjectsController < CrudController
  before_filter :parse_manager_id

  protected
    def get_model
      Projects::Project
    end

    def parse_manager_id
      if params[:projects_project] && params[:projects_project][:manager]
        if params[:projects_project][:manager] =~ %r/\[id:(\d+)\]$/
          id = params[:projects_project][:manager].scan(%r/\[id:(\d+)\]$/)[0][0].to_i
          params[:projects_project][:manager] = Contact::Person.find(id)
        else
          params[:projects_project][:manager] = nil
        end
      end
    end

    def process_form
      super
      @colaborators = Contact::Contact.all
    end
end
