module CrudHelper::Forms
  class FormBuilder < ActionView::Helpers::FormBuilder
    def date_field attribute, options = {}
      text_field attribute, :class => 'input-block-level', 'data-toggle' => 'datepicker'
    end
    def datetime_field attribute, options = {}
      text_field attribute, :class => 'input-block-level', 'data-toggle' => 'datetimepicker'
    end

    def color_field attribute, options = {}
      select attribute, web_safe_colors_options, :class => 'input-block-level'
    end

    def domain_field attribute, options = {}
      collection_select attribute, options[:domain].all, :id, options[:domain].label_field,
        {:include_blank => options[:include_blank]},
        :class => 'input-block-level'
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

    def web_safe_colors_options
      [
        "ffffff","ffccc9","ffce93","fffc9e","ffffc7","9aff99","96fffb","cdffff","cbcefb",
        "cfcfcf","fd6864","fe996b","fffe65","fcff2f","67fd9a","38fff8","68fdff","9698ed",
        "c0c0c0","fe0000","f8a102","ffcc67","f8ff00","34ff34","68cbd0","34cdf9","6665cd",
        "9b9b9b","cb0000","f56b00","ffcb2f","ffc702","32cb00","00d2cb","3166ff","6434fc",
        "656565","9a0000","ce6301","cd9934","999903","009901","329a9d","3531ff","6200c9",
        "343434","680100","963400","986536","646809","036400","34696d","00009b","303498",
        "000000","330001","643403","663234","343300","013300","003532","010066","340096"
      ]
    end
  end

end