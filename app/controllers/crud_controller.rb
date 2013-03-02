class CrudController < ApplicationController
  protect_from_forgery

  def index
    @list = get_model.all
  end

  def show
    @row = get_model.find(params[:id])
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @post }
    end
  end

  def edit
    @row = get_model.find(params[:id])
  end

  def update
    @row = get_model.find(params[:id])
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
    @row = get_model.new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @row }
    end
  end

  def create
    @row = get_model.new(params[get_model_name])
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
    @row = get_model.find(params[:id])
    @row.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end 

  protected
    def get_model_from_controller klass
      controller_class_name = klass.name
      plural = controller_class_name.gsub %r/Controller$/, ''
      splitted = plural.split('::')
      const_name = Object.const_get(splitted.shift.singularize)
      splitted.each do |p|
        const_name = const_name.const_get(p.singularize)
      end
      const_name
    end

    def get_model
      get_model_from_controller self.class
    end

    def get_model_name
      get_model.to_s.underscore.gsub('/', '_')
    end
end