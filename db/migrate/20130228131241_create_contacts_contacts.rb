class CreateContactsContacts < ActiveRecord::Migration
  def self.up
    create_table :contact_contacts do |t|
      t.string :type
    	t.string :fullname
    	t.date   :birthdate
    	t.text   :note
      t.timestamps
    end
  end

  def self.down
    drop_table :contact_contacts
  end
end
