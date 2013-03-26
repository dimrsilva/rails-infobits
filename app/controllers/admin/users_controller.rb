class Admin::UsersController < CrudController
  protected
    def load_table_list_columns
      @table_list_columns = [:id, :email]
    end
end
