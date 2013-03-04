class Contact::Property::Email < Contact::Property::Property
  default_scope :conditions => ["type = ?","Contact::Property::Email"]
  # attr_accessible :title, :body
end
