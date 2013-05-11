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

  # Amount should be a decimal between 0 and 1. Lower means darker
  def darken_color(hex_color, amount=0.4)
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = (rgb[0].to_i * amount).round
    rgb[1] = (rgb[1].to_i * amount).round
    rgb[2] = (rgb[2].to_i * amount).round
    "%02x%02x%02x" % rgb
  end
  
  # Amount should be a decimal between 0 and 1. Higher means lighter
  def lighten_color(hex_color, amount=0.6)
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] = [(rgb[0].to_i + 255 * amount).round, 255].min
    rgb[1] = [(rgb[1].to_i + 255 * amount).round, 255].min
    rgb[2] = [(rgb[2].to_i + 255 * amount).round, 255].min
    "%02x%02x%02x" % rgb
  end

  def contrasting_text_color(hex_color, amount = 0.4)
    if convert_to_brightness_value(hex_color) > 382.5
      darken_color(hex_color, amount)
    else
      lighten_color(hex_color, 1 - amount)
    end
  end
  
  def convert_to_brightness_value(hex_color)
     (hex_color.scan(/../).map {|color| color.hex}).sum
  end
end
