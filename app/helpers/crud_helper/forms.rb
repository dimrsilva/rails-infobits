module CrudHelper::Forms
  class FormBuilder < ActionView::Helpers::FormBuilder
    def date_field attribute
      text_field attribute, :type => :date

    # <div class="input-append date" id="dp3" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
    #   <input class="span2" size="16" type="text" value="12-02-2012">
    #   <span class="add-on"><i class="icon-th"></i></span>
    # </div>
    end

    def nested_resource association
      @template.render "form_fields_nested_resources", :association => association, :form => self
    end
  end
end