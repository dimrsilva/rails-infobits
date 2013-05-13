class AddSprintDatetimeToProjectsTasks < ActiveRecord::Migration
  def change
    change_table :projects_tasks do |t|
      t.datetime :sprint_datetime
    end
  end
end
