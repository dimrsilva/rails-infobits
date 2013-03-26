class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      @breadcrumbs << [name, url]
    end
end
