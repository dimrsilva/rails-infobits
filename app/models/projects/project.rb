class Projects::Project < ActiveRecord::Base

  def self.label_field
    :title
  end

  attr_accessible :description, :end_date, :start_date, :title, :domain_id, :manager

  belongs_to :status, :class_name => "Projects::Status", :foreign_key => "domain_id"
  belongs_to :manager, :class_name => "Contact::Person", :foreign_key => "contact_person_id"
end
