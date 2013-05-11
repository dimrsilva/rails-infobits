class Projects::Fixture < ActiveRecord::Base

  def self.label_field
    :title
  end

  attr_accessible :color, :project_id, :title

  validates_format_of :color, :with => /^(?:[0-9A-F]{6}|[0-9A-F]{3})$/i

  belongs_to :project, :class_name => 'Projects::Project', :foreign_key => :project_id
  has_many :tasks, :class_name => 'Projects::Task', :foreign_key => :fixture_id, :dependent => :nullify
end
