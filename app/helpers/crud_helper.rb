module CrudHelper

  def _form_fields_map_widgets column
    map = {
      :binary      => 'text_field',
      :boolean     => 'text_field',
      :date        => 'text_field',
      :datetime    => 'text_field',
      :decimal     => 'text_field',
      :float       => 'text_field',
      :integer     => 'text_field',
      :primary_key => 'text_field',
      :string      => 'text_field',
      :text        => 'text_area',
      :time        => 'text_field',
      :timestamp   => 'text_field'
    }
    map[column.type]
  end

  def form_fields
    @row.class.columns.each do |column|
      if !%r/id|type|(?:creat|updat)ed_at/.match column.name 
        yield :name => column.name, :widget => self._form_fields_map_widgets(column)
      end
    end
  end

  def show_fields
    @row.class.columns.each do |column|
      if !%r/id|type|(?:creat|updat)ed_at/.match column.name 
        yield :name => column.name, :widget => self._form_fields_map_widgets(column)
      end
    end
  end

  class FormBuilder < ActionView::Helpers::FormBuilder
    def date_field

    # <div class="input-append date" id="dp3" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
    #   <input class="span2" size="16" type="text" value="12-02-2012">
    #   <span class="add-on"><i class="icon-th"></i></span>
    # </div>
    end
  end

end
