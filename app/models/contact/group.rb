class Contact::Group < ActiveRecord::Base

  def self.label_field
    :name
  end

  attr_accessible :name
end
