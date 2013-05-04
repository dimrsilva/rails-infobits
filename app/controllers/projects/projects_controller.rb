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
end
