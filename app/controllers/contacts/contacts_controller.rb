class Contacts::ContactsController < ApplicationController
  include Core::CrudResource

  protected
    def fill_aditional_properties
      @row.emails.build
      @row.addresses.build
      @row.phones.build
    end

    def get_list_model
      Contact::Contact
    end

    def load_index_actions
      if can? :create, Contact::Contact
        @action_buttons << {
          :text => I18n.t('helpers.link.create', :model => Contact::Person.model_name.human),
          :url => new_contact_person_path
        }
        @action_buttons << {
          :text => I18n.t('helpers.link.create', :model => Contact::Company.model_name.human),
          :url => new_contact_company_path
        }
      end
    end

    def init
      super
      @title = I18n.t 'helpers.index.list', :model => I18n.t(:contacts)
    end

    def process_form
      super
      @contact_groups = Contact::Group.all
      fill_aditional_properties
    end
end
