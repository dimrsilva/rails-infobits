class Contact::Company < Contact::Contact
  acts_as_citier
  attr_accessible :fantasy_name, :legal_name, :doc_cnpj, :doc_ie, :doc_im, :representant
  belongs_to :representant, :class_name => "Contact::Person"

  validates :fantasy_name, :presence => true, :length => {:minimum => 3}

  def fantasy_name= new_val
    super new_val.strip
    self.fullname = self.fantasy_name
    self.fantasy_name
  end

end
