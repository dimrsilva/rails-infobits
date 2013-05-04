class CreateProjectsTasks < ActiveRecord::Migration
  def change
    create_table :projects_tasks do |t|
      t.string :title
      t.text :description
      t.integer :estimated_time
      t.integer :real_time
      t.integer :project_id, :references => :projects_projects
      t.integer :responsible_id, :references => :contact_contacts
      t.integer :task_status_id, :references => :projects_task_statuses

      t.timestamps
    end
  end
end
