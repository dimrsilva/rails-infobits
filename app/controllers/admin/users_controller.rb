class Admin::UsersController < CrudController
  protected
    def filter_list q
      @list.where("email LIKE '%#{q}%'")
    end

    def load_table_list_columns
      @table_list_columns = [:id, :email]
    end
end
