class Projects::TaskStatus < Domain
  acts_as_citier

  validates_format_of :color, :with => /^(?:[0-9A-F]{6}|[0-9A-F]{3})$/i

  def self.label_field
    :label
  end

  attr_accessible :percent, :color

  def label
    "#{percent}% - #{value}"
  end
end
