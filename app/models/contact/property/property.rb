class Contact::Property::Property < ActiveRecord::Base

  def self.label_field
    :value
  end

  acts_as_citier
  attr_accessible :label, :value
end
