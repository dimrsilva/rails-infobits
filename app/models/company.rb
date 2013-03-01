class Company < Contact
	acts_as_citier

	# belongs_to :representant, :class => "Person", :foreign_key => "representant_id"
end
