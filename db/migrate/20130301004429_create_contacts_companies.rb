class CreateContactsCompanies < ActiveRecord::Migration
  def self.up
    create_table :contact_companies do |t|
    	t.string :fantasy_name
    	t.string :legal_name
			t.string :doc_cnpj
			t.string :doc_ie
			t.string :doc_im
      t.references :contact_person
    end
    create_citier_view Contact::Company
  end

  def self.down
    drop_citier_view Contact::Company
    drop_table :contact_companies
  end
end
