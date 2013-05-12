class Projects::Task < ActiveRecord::Base

  def self.label_field
    :title
  end

  scope :roots, where(:parent_id => nil)
  
  attr_accessible :description, :estimated_effort,
    :real_effort, :title, :responsible_id, :task_status_id, :fixture_id,
    :index_position, :parent_id

  belongs_to :project, :class_name => 'Projects::Project', :foreign_key => :project_id
  belongs_to :task_status, :class_name => 'Projects::TaskStatus', :foreign_key => :task_status_id
  belongs_to :responsible, :class_name => 'Contact::Contact', :foreign_key => :responsible_id
  belongs_to :fixture, :class_name => 'Projects::Fixture', :foreign_key => :fixture_id

  belongs_to :parent_task, :class_name => 'Projects::Task', :foreign_key => :parent_id
  has_many :children_tasks, :class_name => 'Projects::Task', :foreign_key => :parent_id
end
