class CreateProjectsProjects < ActiveRecord::Migration
  def change
    create_table :projects_projects do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :manager_id, :references => :contact_contacts
      t.integer :status_id, :references => :domains

      t.timestamps
    end
  end
end
