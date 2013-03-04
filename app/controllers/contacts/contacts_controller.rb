class Contacts::ContactsController < CrudController
  def load_list
    @list = Contact::Contact.all
  end
end
