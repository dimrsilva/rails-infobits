class Contact::Person < Contact::Contact
  acts_as_citier

  attr_accessible :prefix, :firstname, :middlename, :lastname, :doc_cpf, :doc_rg 
end
