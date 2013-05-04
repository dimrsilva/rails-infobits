class Projects::TaskStatusesController < ApplicationController
  include Core::CrudResource
  protected
    def get_model
      Projects::TaskStatus
    end

    def order_list
      @list.order(:percent)
    end
end
