class Contacts::ContactsController < CrudController

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

    def process_form
      super
      @contact_groups = Contact::Group.all
      fill_aditional_properties
    end
end
