class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!

  protected
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      @breadcrumbs << [name, url]
    end
end
