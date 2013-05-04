class Contact::Group < ActiveRecord::Base

  def self.label_field
    :name
  end

  attr_accessible :name,
    :acts_as_colaborator,
    :acts_as_administrator,
    :acts_as_project_manager,
    :acts_as_project_director
    
  has_and_belongs_to_many :contacts, :class_name => 'Contact::Contact', :foreign_key => :contact_group_id,
    :association_foreign_key => :contact_contact_id, :join_table => :contact_contacts_groups

  before_destroy :group_with_contacts?

  private

    def group_with_contacts?
      message = I18n.t('activerecord.errors.models.contact/group.delete.contacts_exists')
      errors.add(:base, message) unless contacts.count == 0
      errors.blank? #return false to not destroy the element, otherwise, it will delete.
    end
end
