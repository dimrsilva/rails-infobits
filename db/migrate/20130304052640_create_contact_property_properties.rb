class CreateContactPropertyProperties < ActiveRecord::Migration
  def change
    create_table :contact_property_properties do |t|
      t.string :type
      t.string :label
      t.string :value
      t.integer :contact_contact_id

      t.timestamps
    end
  end
end
