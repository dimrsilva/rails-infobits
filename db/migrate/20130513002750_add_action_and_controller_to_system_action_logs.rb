class AddActionAndControllerToSystemActionLogs < ActiveRecord::Migration
  def change
    change_table :system_action_logs do |t|
      t.string :action
      t.string :controller
    end
  end
end
