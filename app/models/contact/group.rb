class Contact::Group < ActiveRecord::Base
  attr_accessible :name

  self.field_name = :name

  def table_list_columns
    yield :id
    yield :name
  end
end
