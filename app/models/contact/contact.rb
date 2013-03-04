class Contact::Contact < ActiveRecord::Base
  acts_as_citier
  attr_accessible :fullname, :birthdate, :note
  has_many :emails, :class_name => 'Contact::Property::Email', :dependent => :destroy, :autosave => true
  has_many :phones, :class_name => 'Contact::Property::Phone', :dependent => :destroy, :autosave => true
  has_many :addresses, :class_name => 'Contact::Property::Address', :dependent => :destroy, :autosave => true

  def table_list_columns
    yield :id
    yield :fullname
  end
end
