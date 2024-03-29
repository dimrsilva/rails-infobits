class Projects::TasksController < ApplicationController
  before_filter :find_project
  include Core::CrudResource
  after_filter :log_action, :only => [:batch_update]

  def index
    redirect_to @project
  end

  def update
    respond_to do |format|
      if @row.update_attributes(params[get_model_name])
        format.html  { redirect_to(@project,
                      :notice => get_translation(:update, :success)) }
        format.json  { head :no_content }
      else
        process_form
        format.html  { render :action => "edit" }
        format.json  { render :json => @row.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def batch_update
    @row = Projects::Task.find(params[:id])
    @project = @row.project
    params[:projects_tasks].each do |task_attrs|
      task = Projects::Task.find(task_attrs[1][:id].to_i)
      task.update_attributes(task_attrs[1])
    end
    render :nothing => true, :status => 200
  end

  def create
    @row.attributes = params[get_model_name]
    respond_to do |format|
      if @row.save
        format.html  { redirect_to(@project,
                      :notice => get_translation(:create, :success)) }
        format.json  { render :json => @row,
                      :status => :created, :location => @row }
      else
        process_form
        format.html  { render :action => "new" }
        format.json  { render :json => @row.errors,
                      :status => :unprocessable_entity }
      end
    end 
  end

  def destroy
    respond_to do |format|
      if @row.destroy
        format.html  { redirect_to(@project,
                      :notice => get_translation(:destroy, :success)) }
        format.json  { head :no_content }
      else
        format.html  { redirect_to(@project,
                      :alert => @row.errors.full_messages.join('<br/>')) }
        format.json  { render :json => @row.errors,
                      :status => :unprocessable_entity }
      end
    end
  end 

  protected
    def get_model
      Projects::Task
    end

    def load_edit_actions
    end

    def process_form
      @colaborators = @project.colaborators
      @fixtures = @project.fixtures
      @action_buttons << {
        :text => I18n.t('helpers.link.back_to', :model => Projects::Project.model_name.human),
        :url => projects_project_path(@row.project)
      }
    end

    def find_project
      @project = Projects::Project.find(params[:projects_project_id])
    end

    def find_row
      if params[:id]
        super
      else
        @row = get_model.new
        @row.project = @project
      end
    rescue
      render "/errors/404", :status => 404
    end

    def linked_log_action
      @project
    end
end
