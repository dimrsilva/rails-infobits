class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.string :name

      t.timestamps
    end
    create_table :contact_contacts_groups do |t|
      t.integer :contact_contact_id, :null => false
      t.integer :contact_group_id, :null => false
    end
  end
end
