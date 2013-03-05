class Contact::Company < Contact::Contact
  acts_as_citier
  attr_accessible :fantasy_name, :legal_name, :doc_cnpj, :doc_ie, :doc_im
  belongs_to :representant, :class_name => "Contact::Person", :foreign_key => "contact_person_id"

  def fantasy_name= new_val
    super new_val.strip
    self.fullname = self.fantasy_name
    self.fantasy_name
  end

end
