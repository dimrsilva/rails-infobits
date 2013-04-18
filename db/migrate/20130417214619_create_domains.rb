class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end
