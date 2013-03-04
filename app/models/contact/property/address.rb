class Contact::Property::Address < Contact::Property::Property
  acts_as_citier
  attr_accessible :city, :country, :neighborhood, :postal_code, :state, :street
end
