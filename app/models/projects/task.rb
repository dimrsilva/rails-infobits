class Projects::Task < ActiveRecord::Base

  def self.label_field
    :title
  end
  
  attr_accessible :description, :estimated_time, :real_time, :title, :responsible_id, :task_status_id

  belongs_to :project, :class_name => 'Projects::Project', :foreign_key => :project_id
  belongs_to :task_status, :class_name => 'Projects::TaskStatus', :foreign_key => :task_status_id
  # belongs_to :responsible, :class_name => 'Contacts::Contact', :foreign_key => :responsiblee_id
end
