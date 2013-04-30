class Projects::StatusesController < ApplicationController
  include Core::CrudResource
  protected
    def get_model
      Projects::Status
    end
end
