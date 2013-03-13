class Contacts::GroupsController < CrudController
  protected
    def filter_list q
      @list.where("name LIKE '%#{q}%'")
    end

    def load_table_list_columns
      @table_list_columns = [:id, :name]
    end
end
