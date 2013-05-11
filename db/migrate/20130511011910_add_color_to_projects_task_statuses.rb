class AddColorToProjectsTaskStatuses < ActiveRecord::Migration
  def self.up
    add_column :projects_task_statuses, :color, :string
    drop_citier_view Projects::TaskStatus
    create_citier_view Projects::TaskStatus
  end

  def self.down
    remove_column :projects_task_statuses, :color
    drop_citier_view Projects::TaskStatus
    create_citier_view Projects::TaskStatus
  end
end
