class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
    	t.string :fantasy_name
    	t.string :legal_name
			t.string :doc_cnpj
			t.string :doc_ie
			t.string :doc_im
    end
    create_citier_view Company
  end

  def self.down
    execute 'DROP VIEW view_companies'
    drop_table :companies
  end
end
