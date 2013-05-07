module Core
  module CrudResource
    extend ActiveSupport::Concern

    included do
      rescue_from CanCan::AccessDenied, :with => lambda { render "/errors/403", :status => 403 }
      rescue_from ActiveRecord::RecordNotFound, :with => lambda { render "/errors/404", :status => 404 }
      before_filter :init
      before_filter :parse_id_inputs
      before_filter :find_row, :only => [:show, :edit, :update, :destroy, :new, :create]
      before_filter :process_form, :only => [:show, :edit, :new]
      # before_filter :load_breadcrumbs
    end

    def index
      load_list
      respond_to do |format|
        format.html  # index.html.erb
        format.json  { render :json => @list }
      end
    end

    def show
      respond_to do |format|
        format.html  # show.html.erb
        format.json  { render :json => @row }
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @row.update_attributes(params[get_model_name])
          format.html  { redirect_to(edit_polymorphic_path(@row),
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
          format.html  { redirect_to(edit_polymorphic_path(@row),
                        :notice => get_translation(:create, :success), :action => :edit) }
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
          format.html  { redirect_to_back(get_model,
                        :notice => get_translation(:destroy, :success)) }
          format.json  { head :no_content }
        else
          format.html  { redirect_to_back(get_model,
                        :alert => @row.errors.full_messages.join('<br/>')) }
          format.json  { render :json => @row.errors,
                        :status => :unprocessable_entity }
        end
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
        get_model.model_name.underscore.gsub('/', '_')
      end

      def get_perm_from_action action
        return case action
          when "show" then :read
          when "edit" then :update
          when "new" then :create
          else action
        end
      end

      def find_row
        perm = get_perm_from_action params[:action]

        if params[:id]
          @row = get_model.find(params[:id].to_i)
        else
          @row = get_model.new
        end
        authorize! perm, @row
      end

      def init
        @template_row = get_model.new
        @title = I18n.t self.class.name.underscore.gsub(%r/_controller$/, '')
        @per_page = 10
        prepend_view_path 'app/views/crud'
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
        authorize! :read, get_list_model
        @list = get_list_model
        @list = filter_list params[:q] unless params[:q] == nil
        @list = order_list
        @list = paginate_list
        load_table_list_columns
      end

      def process_form
      end

      def load_breadcrumbs
        add_breadcrumb I18n.t(:home), root_url
        add_breadcrumb @title, polymorphic_url(get_model)
        if @row
          if @row.new_record?
            add_breadcrumb I18n.t(:create), new_polymorphic_url(get_model)
          else
            add_breadcrumb I18n.t(:edit), edit_polymorphic_url(@row)
          end
        end
      end

      def redirect_to_back(default = root_url, options = {})
        if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
          redirect_to :back, options
        else
          redirect_to default, options
        end
      end

      def get_translation action, type
        I18n.translate!("controllers.#{self.class.name.underscore}.messages.#{action}.#{type}", :row => get_model.model_name.human)
      rescue I18n::MissingTranslationData
        I18n.translate("controllers.messages.#{action}.#{type}", :row => get_model.model_name.human)
      end

      def parse_id_inputs
        if params[get_model_name]
          params[get_model_name].each do |key, value|
            get_model.reflect_on_all_associations.each do |assoc|
              if(assoc.name.to_s == key.to_s)
                if value =~ %r/\[id:\d+\]/
                  assoc_model = eval(assoc.options[:class_name])
                  params[get_model_name][key] = assoc_model.find(value.scan(%r/\[id:(\d+)\]$/)[0][0].to_i)
                else
                  params[get_model_name][key] = nil
                end
                break
              end
            end
          end
        end
      end
  end
end