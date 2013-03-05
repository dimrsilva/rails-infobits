class Contacts::ContactsController < CrudController

  before_filter :fill_aditional_properties, :only => [:new, :edit, :show]

  def load_list
    @list = Contact::Contact.all
  end

  protected
    def fill_aditional_properties
      @row ||= get_model.new
      @row.emails.build
      @row.addresses.build
      @row.phones.build
    end
end
