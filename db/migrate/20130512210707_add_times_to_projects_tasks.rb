class AddTimesToProjectsTasks < ActiveRecord::Migration
  def change
    change_table :projects_tasks do |t|
      t.datetime :start_datetime
      t.datetime :end_datetime
    end
  end
end
