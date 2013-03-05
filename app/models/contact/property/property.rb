class Contact::Property::Property < ActiveRecord::Base
  acts_as_citier
  attr_accessible :label, :value
end
