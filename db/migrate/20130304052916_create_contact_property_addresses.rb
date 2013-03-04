class CreateContactPropertyAddresses < ActiveRecord::Migration
  def self.up
    create_table :contact_property_addresses do |t|
      t.string :street
      t.string :neighborhood
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country
    end
    create_citier_view Contact::Property::Address
  end

  def self.down
    drop_citier_view Contact::Property::Address
    drop_table :contact_property_addresses
  end
end
