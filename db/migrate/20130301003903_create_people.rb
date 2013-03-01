class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :prefix
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :doc_cpf
      t.string :doc_rg
    end
    create_citier_view Person
  end

  def self.down
    execute 'DROP VIEW view_people'
    drop_table :people
  end
end
