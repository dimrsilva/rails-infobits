class Projects::Task < ActiveRecord::Base

  before_save :automate_datetimes

  def self.label_field
    :title
  end

  scope :roots, where(:parent_id => nil)
  
  attr_accessible :description, :estimated_effort,
    :real_effort, :title, :responsible_id, :task_status_id, :fixture_id,
    :index_position, :parent_id,
    :start_datetime, :end_datetime, :sprint_datetime

  belongs_to :project, :class_name => 'Projects::Project', :foreign_key => :project_id
  belongs_to :task_status, :class_name => 'Projects::TaskStatus', :foreign_key => :task_status_id
  belongs_to :responsible, :class_name => 'Contact::Contact', :foreign_key => :responsible_id
  belongs_to :fixture, :class_name => 'Projects::Fixture', :foreign_key => :fixture_id

  belongs_to :parent_task, :class_name => 'Projects::Task', :foreign_key => :parent_id
  has_many :children_tasks, :class_name => 'Projects::Task', :foreign_key => :parent_id

  def self.of_sprint start_date, end_date
    sdt = start_date.beginning_of_day.to_formatted_s :db
    edt = end_date.end_of_day.to_formatted_s :db
    where("(" +
          "(sprint_datetime >= '#{sdt}' AND sprint_datetime <= '#{edt}') OR " +
          "(start_datetime >= '#{sdt}' AND start_datetime <= '#{edt}') OR " +
          "(end_datetime >= '#{sdt}' AND end_datetime <= '#{edt}')" +
          ")")
  end

  def self.sprinted
    self.joins(:task_status).where('view_projects_task_statuses.percent > 5')
  end

  def self.started
    self.joins(:task_status).where('view_projects_task_statuses.percent > 10')
  end

  def self.finished
    self.joins(:task_status).where('view_projects_task_statuses.percent > 90')
  end

  private
    def automate_datetimes
      original = id ? Projects::Task.find(id) : self
      if id and original.task_status_id != self.task_status_id
        if original.sprint_datetime == nil and task_status != nil and task_status.sprinted?
          self.sprint_datetime = DateTime.now
        end
        if original.start_datetime == nil and task_status != nil and task_status.work_started?
          self.start_datetime = DateTime.now
        end
        if original.end_datetime == nil and task_status != nil and task_status.work_finished?
          self.end_datetime = DateTime.now
        end
      end
    end
end
