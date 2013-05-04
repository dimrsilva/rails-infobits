class Admin::UsersController < ApplicationController
  include Core::CrudResource

  before_filter :parse_contact_id
  
  protected
    def parse_contact_id
      if params[:admin_user] && params[:admin_user][:contact]
        id = params[:admin_user][:contact].scan(%r/\[id:(\d+)\]$/)[0][0].to_i
        params[:admin_user][:contact] = Contact::Person.find(id)
      end
    end

    def load_table_list_columns
      @table_list_columns = [:id, :email]
    end
end
