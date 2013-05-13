class Projects::ProjectsController < ApplicationController
  include Core::CrudResource

  def show
    @task_statuses_count = Projects::TaskStatus.count
    @task_statuses = Projects::TaskStatus.order(:percent).all
    super
  end

  def new
    @row.manager = current_user.contact
    super
  end

  def burndown
    find_row
    load_edit_actions
    @title = @row.title
    params[:start] ||= DateTime.now.at_beginning_of_week
    params[:end] ||= DateTime.now.at_end_of_week
    if params[:start] and params[:end]
      @start_sprint_date = DateTime.parse(params[:start].to_s)
      @end_sprint_date = DateTime.parse(params[:end].to_s)

      @days_count = (@end_sprint_date - @start_sprint_date).to_i
      _sprint_tasks = @row.tasks.of_sprint(@start_sprint_date, @end_sprint_date)
      @tasks_count = _sprint_tasks.count

      @perfect_burndown = [@tasks_count]
      @real_burndown = [@tasks_count]

      _current_day = @start_sprint_date
      @days_count.times do |i|
        _current_day = _current_day.tomorrow
        @perfect_burndown << (@tasks_count.to_f * ((@days_count - i - 1).to_f / @days_count.to_f))
        @real_burndown << @tasks_count - _sprint_tasks.where("end_datetime <= '#{_current_day.to_formatted_s(:db)}'").count
      end
    end
  end

  protected
    def fill_aditional_fixture
      @row.fixtures.build
    end

    def get_model
      Projects::Project
    end

    def load_table_list_columns
      @table_list_columns = [:id, :title, :tasks]
    end

    def process_form
      super
      @managers = Contact::Contact.joins(:groups).where(:contact_groups => {:acts_as_project_manager => true}).group('contact_contacts.id')
      @colaborators = Contact::Contact.joins(:groups).where(:contact_groups => {:acts_as_colaborator => true}).group('contact_contacts.id')
      fill_aditional_fixture
    end

    def load_show_actions
      super
      if can? :create, Projects::Task
        @action_buttons << {
          :text => I18n.t('helpers.link.create', :model => Projects::Task.model_name.human),
          :url => new_projects_project_projects_task_path(:projects_project_id => @row.id)
        }
      end
      if can? :read, Projects::Task
        @action_buttons << {
          :text => I18n.t('helpers.link.burndown_graph'),
          :url => burndown_projects_project_path(@row)
        }
      end
    end
end
