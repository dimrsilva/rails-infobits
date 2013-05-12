class Projects::TaskStatus < Domain
  acts_as_citier

  def self.label_field
    :label
  end

  # Percent indicate the amount of work done
  # Values less or equal 10 indicates nothing is done yet
  # Values greater or equal 90 indicates the work is done
  attr_accessible :percent

  def label
    "#{percent}% - #{value}"
  end

  def work_started?
    percent and percent > 10
  end

  def work_finished?
    percent and percent > 90
  end
end
