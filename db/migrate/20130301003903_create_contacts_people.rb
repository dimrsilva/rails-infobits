class CreateContactsPeople < ActiveRecord::Migration
  def self.up
    create_table :contact_people do |t|
      t.string :prefix
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :doc_cpf
      t.string :doc_rg
    end
    create_citier_view Contact::Person
  end

  def self.down
    drop_citier_view Contact::Person
    drop_table :contact_people
  end
end
