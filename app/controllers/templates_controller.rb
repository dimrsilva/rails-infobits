class TemplatesController < ApplicationController
  before_filter :init

  def init
    @title = 'Pagina Inicial'
    @subtitle = 'Subtitulo da pagina inicial'
  end
end
