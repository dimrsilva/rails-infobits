class CreateProjectsTaskStatuses < ActiveRecord::Migration
  def self.up
    create_table :projects_task_statuses do |t|
      t.integer :percent
    end
    create_citier_view Projects::TaskStatus
  end

  def self.down
    drop_citier_view Projects::TaskStatus
    drop_table :projects_task_statuses
  end
end
