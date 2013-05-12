module CrudHelper

  def _form_fields_map_widgets column
    map = {
      :binary      => 'text_field',
      :boolean     => 'check_box',
      :date        => 'date_field',
      :datetime    => 'datetime_field',
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
      if column.name.to_s == 'color'
        yield :name => column.name, :widget => :color_field
      elsif !%r/id|type|(?:creat|updat)ed_at$/.match column.name 
        yield :name => column.name, :widget => self._form_fields_map_widgets(column)
      end
    end
  end

  def show_fields
    @row.class.columns.each do |column|
      if !%r/id|type|(?:creat|updat)ed_at$/.match column.name 
        yield :name => column.name, :widget => self._form_fields_map_widgets(column)
      end
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("form_fields_#{association.to_s.singularize}", :form => builder)
    end
    fields = "<div class=\"nested-resource-item\">#{fields}</div>"
    f.submit(name, class: "btn btn-link add-fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  # change the default link renderer for will_paginate
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => CrudHelper::Paginator::LinkRenderer
    end
    super *[collection_or_options, options].compact
  end

end
