class CrudController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :init
  before_filter :find_row, :only => [:show, :edit, :update, :destroy, :new, :create]

  def index
  end

  def show
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @post }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @row.update_attributes(params[get_model_name])
        format.html  { redirect_to(@row,
                      :notice => 'Row was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @row.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @row }
    end
  end

  def create
    @row.attributes = params[get_model_name]
    respond_to do |format|
      if @row.save
        format.html  { redirect_to(@row,
                      :notice => 'Row was successfully created.') }
        format.json  { render :json => @row,
                      :status => :created, :location => @row }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @row.errors,
                      :status => :unprocessable_entity }
      end
    end 
  end

  def destroy
    @row.destroy
    respond_to do |format|
      format.html { redirect_to get_model }
      format.json { head :no_content }
    end
  end 

  protected
    def get_model_from_controller klass
      controller_class_name = klass.name
      plural = controller_class_name.gsub %r/Controller$/, ''
      splitted = plural.split('::')
      const = Object.const_get(splitted.shift.singularize)
      splitted.each do |p|
        # Get const not searching on parent modules
        const = const.const_get(p.singularize, false)
      end
      const
    end

    def get_model
      get_model_from_controller self.class
    end

    def get_list_model
      get_model
    end

    def get_model_name
      get_model.to_s.underscore.gsub('/', '_')
    end

    def find_row
      if params[:id]
        @row = get_model.find(params[:id])
      else
        @row = get_model.new
      end
    end

    def init
      @template_row = get_model.new
      @title = t self.class.name.underscore.gsub(%r/_controller$/, '')
      load_list
    end

    def load_list
      @list = get_list_model.order(get_list_model.field_name)
        .paginate(:page => params[:page], :per_page => 10)
    end
end