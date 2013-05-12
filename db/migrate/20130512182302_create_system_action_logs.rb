class CreateSystemActionLogs < ActiveRecord::Migration
  def change
    create_table :system_action_logs do |t|
      t.integer :user_id, :references => :admin_users
      t.text :params
      t.string :affected_type
      t.integer :affected_id, :references => false
      t.string :linked_type
      t.integer :linked_id, :references => false

      t.string :ipaddress
      t.string :referer

      t.timestamps
    end
  end
end
