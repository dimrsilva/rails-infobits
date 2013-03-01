class CrudController < ApplicationController
  protect_from_forgery

  def index
  	@list = self._get_model.all
  end

  protected
    def _get_model
    	controller_name = self.class.name
    	match = %r/(\w+)Controller/.match controller_name
    	offset = match.offset(1)
    	plural = controller_name[offset[0],offset[1]]
    	Object.const_get(plural.singularize)
    end
end