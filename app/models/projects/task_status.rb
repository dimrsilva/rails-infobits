class Projects::TaskStatus < Domain
  acts_as_citier

  def self.label_field
    :label
  end

  attr_accessible :percent

  def label
    "#{percent}% - #{value}"
  end
end
