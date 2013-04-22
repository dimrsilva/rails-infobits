class Projects::StatusesController < CrudController
  protected
    def get_model
      Projects::Status
    end
end
