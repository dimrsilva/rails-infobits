class AddIndexAndParentIdToProjectsTasks < ActiveRecord::Migration
  def change
    change_table :projects_tasks do |t|
      t.integer :parent_id, :references => :projects_tasks
      t.integer :index_position
    end
  end
end
