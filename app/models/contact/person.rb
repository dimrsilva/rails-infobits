class Contact::Person < Contact::Contact
  acts_as_citier

  has_many :represented_companies, :class_name => 'Contact::Company', :foreign_key => 'representant_id'

  attr_accessible :prefix, :firstname, :middlename, :lastname, :doc_cpf, :doc_rg 

  validates :firstname, :presence => true, :length => {:minimum => 3}
  before_destroy :is_representant?
  
  def prefix= new_val
    super new_val.strip
    set_fullname
    self.prefix
  end

  def firstname= new_val
    super new_val.strip
    set_fullname
    self.firstname
  end

  def middlename= new_val
    super new_val.strip
    set_fullname
    self.middlename
  end

  def lastname= new_val
    super new_val.strip
    set_fullname
    self.lastname
  end

  private
    def set_fullname
      self.fullname = "#{self.prefix} #{self.firstname} #{self.middlename} #{self.lastname}".strip.gsub %r/\s+/, ' '
    end

    def is_representant?
      message = I18n.t('activerecord.errors.models.contact/person.delete.is_representant')
      errors.add(:base, message) unless represented_companies.count == 0
      errors.blank? #return false to not destroy the element, otherwise, it will delete.
    end
end
