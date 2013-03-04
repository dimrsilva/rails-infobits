class Contact::Person < Contact::Contact
  acts_as_citier

  attr_accessible :prefix, :firstname, :middlename, :lastname, :doc_cpf, :doc_rg 
  
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
end
