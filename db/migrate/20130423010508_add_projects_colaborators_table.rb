class AddProjectsColaboratorsTable < ActiveRecord::Migration
  def change
    create_table :projects_colaborators do |t|
      t.integer :contact_contact_id, :null => false
      t.integer :projects_project_id, :null => false
    end
  end
end
