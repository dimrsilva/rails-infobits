class CreateContactPropertyProperties < ActiveRecord::Migration
  def change
    create_table :contact_property_properties do |t|
      t.string :type
      t.string :label
      t.string :value
      t.references :contact_contact

      t.timestamps
    end
  end
end
