class Projects::Project < ActiveRecord::Base

  def self.label_field
    :title
  end

  attr_accessible :description, :end_date, :start_date, :title, :status_id, :manager

  belongs_to :status, :class_name => "Projects::Status"
  belongs_to :manager, :class_name => "Contact::Person"
end
