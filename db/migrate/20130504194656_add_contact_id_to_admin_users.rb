class AddContactIdToAdminUsers < ActiveRecord::Migration
  def change
    change_table :admin_users do |t|
      t.integer :contact_id, :references => :contact_contacts
    end
  end
end
