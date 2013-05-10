module ApplicationHelper

  def link_nav link_text, link_path
    class_name = current_page?(link_path) ? 'active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def parse_text text
    auto_link(simple_format(text)) do |t|
      truncate(t, :length => 30)
    end
  end
end
