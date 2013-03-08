module CrudHelper::Paginator
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    def to_html
      html = pagination.map do |item|
        html_page = '<li>'
        html_page += item.is_a?(Fixnum) ?
          page_number(item) :
          send(item)
        html_page += '</li>'
      end.join('')
      
      @options[:container] ? html_container(html) : html
    end

    protected
      def html_container html
        ul = tag :ul, html
        tag :div, ul, :class => 'pagination'
      end
      
      def page_number page
        unless page == current_page
          link(page, page, :rel => rel_value(page))
        else
          tag(:span, page, :class => 'current')
        end
      end
  end
end