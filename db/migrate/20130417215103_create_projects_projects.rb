class CreateProjectsProjects < ActiveRecord::Migration
  def change
    create_table :projects_projects do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :contact_person
      t.references :domain

      t.timestamps
    end
  end
end
