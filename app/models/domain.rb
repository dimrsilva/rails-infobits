class Domain < ActiveRecord::Base

  def self.field_name
    :value
  end
  
  attr_accessible :value

  def to_s
    "#{value} [id:#{id||'null'}]"
  end
end
