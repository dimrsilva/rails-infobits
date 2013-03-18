class CrudController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :init
  before_filter :find_row, :only => [:show, :edit, :update, :destroy, :new, :create]
  before_filter :process_form, :only => [:show, :edit, :new]

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
        process_form
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
        process_form
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
    rescue ActiveRecord::RecordNotFound
      render "/errors/404", :status => 404
    end

    def init
      @template_row = get_model.new
      @title = t self.class.name.underscore.gsub(%r/_controller$/, '')
      @per_page = 10
      load_list
    end

    def filter_list q
      @list.where("#{get_model.label_field} LIKE '%#{q}%'")
    end

    def order_list
      @list.order(get_model.label_field)
    end

    def paginate_list
      @list.paginate(:page => params[:page], :per_page => @per_page)
    end

    def load_table_list_columns
      @table_list_columns = [:id, get_model.label_field]
    end

    def load_list
      @list = get_list_model
      @list = filter_list params[:q] unless params[:q] == nil
      @list = order_list
      @list = paginate_list
      load_table_list_columns
    end

    def process_form
    end
end
