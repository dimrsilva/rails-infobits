module CrudHelper::Forms
  class FormBuilder < ActionView::Helpers::FormBuilder
    def date_field attribute, options = {}
      text_field attribute, :class => 'datepicker input-block-level', 'data-toggle' => 'datepicker'
    end

    def domain_field attribute, options = {}
      collection_select attribute, options[:domain].all, :id, options[:domain].label_field, {}, :class => 'input-block-level'
    end

    def nested_resource association
      @template.render "form_fields_nested_resources", :association => association, :form => self
    end

    def labeled_input name, type = 'text_field', options = {}
      options['class'] = 'input-block-level'
      @template.content_tag(:div, :class => "control-group control-group-#{name}") do
        label(name, :class => 'control-label') +
        @template.content_tag(:div, :class => 'controls') do
          send(type, name, options)
        end
      end
    end
  end
end