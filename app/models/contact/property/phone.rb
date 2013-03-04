class Contact::Property::Phone < Contact::Property::Property
  default_scope :conditions => ["type = ?","Contact::Property::Phone"]
  # attr_accessible :title, :body
end
