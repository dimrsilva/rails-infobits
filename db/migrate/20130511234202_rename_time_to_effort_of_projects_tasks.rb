class RenameTimeToEffortOfProjectsTasks < ActiveRecord::Migration
  def change
    rename_column :projects_tasks, :estimated_time, :estimated_effort
    rename_column :projects_tasks, :real_time, :real_effort
  end
end
