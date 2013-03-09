class Contacts::ContactsController < CrudController

  before_filter :fill_aditional_properties, :only => [:new, :edit, :show]

  protected
    def fill_aditional_properties
      @row.emails.build
      @row.addresses.build
      @row.phones.build
    end

    def get_list_model
      Contact::Contact
    end

    def init
      super
      @title = t :contacts
    end
end
