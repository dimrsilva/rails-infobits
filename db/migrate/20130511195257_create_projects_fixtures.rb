class CreateProjectsFixtures < ActiveRecord::Migration
  def self.up
    create_table :projects_fixtures do |t|
      t.string :title
      t.string :color
      t.integer :project_id, :references => :projects_projects

      t.timestamps
    end

    change_table :projects_tasks do |t|
      t.integer :fixture_id, :references => :projects_fixtures
    end

    drop_citier_view Projects::TaskStatus
    remove_column :projects_task_statuses, :color
    create_citier_view Projects::TaskStatus
  end

  def self.down
    drop_citier_view Projects::TaskStatus
    add_column :projects_task_statuses, :color, :string
    create_citier_view Projects::TaskStatus

    remove_column :projects_tasks, :fixture_id

    drop_table :projects_fixtures
  end
end
