class AddRolesToContactsGroups < ActiveRecord::Migration
  def change
    change_table :contact_groups do |t|
      t.boolean :acts_as_administrator
      t.boolean :acts_as_project_manager
      t.boolean :acts_as_project_director
    end
  end
end
