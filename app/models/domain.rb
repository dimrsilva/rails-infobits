class Domain < ActiveRecord::Base

  def self.label_field
    :value
  end
  
  attr_accessible :value

  def to_s
    "#{value} [id:#{id||'null'}]"
  end
end
