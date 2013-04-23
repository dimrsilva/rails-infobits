class AddActsAsColaboratorToContactsGroups < ActiveRecord::Migration
  def change
    change_table :contact_groups do |t|
      t.boolean :acts_as_colaborator
    end
  end
end
