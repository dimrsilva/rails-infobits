class Contact::Company < Contact::Contact
  acts_as_citier

  attr_accessible :fantasy_name, :legal_name, :doc_cnpj, :doc_ie, :doc_im

	# belongs_to :representant, :class => "Person", :foreign_key => "representant_id"
end
