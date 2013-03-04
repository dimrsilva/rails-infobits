class Contact::Contact < ActiveRecord::Base
  acts_as_citier

  attr_accessible :fullname, :birthdate, :note

  def table_list_columns
    yield :id
    yield :fullname
  end
end
