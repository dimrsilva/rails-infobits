class Projects::Project < ActiveRecord::Base

  def self.label_field
    :title
  end

  attr_accessible :description, :end_date, :start_date, :title, :status_id, :manager, :colaborator_ids

  belongs_to :status, :class_name => "Projects::Status"
  belongs_to :manager, :class_name => "Contact::Person"

  has_and_belongs_to_many :colaborators, :class_name => 'Contact::Contact', :foreign_key => :projects_project_id,
    :association_foreign_key => :contact_contact_id, :join_table => :projects_colaborators
end
