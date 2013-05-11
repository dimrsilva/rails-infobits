class Contact::Contact < ActiveRecord::Base

  def self.label_field
    :fullname
  end

  acts_as_citier
  attr_accessible :fullname, :birthdate, :note,
    :emails, :emails_attributes,
    :phones, :phones_attributes,
    :addresses, :addresses_attributes,
    :group_ids

  has_many :emails, :class_name => 'Contact::Property::Email',
    :foreign_key => :contact_contact_id, :dependent => :delete_all, :autosave => true
  accepts_nested_attributes_for :emails, :reject_if => :reject_empty_properties, :allow_destroy => true

  has_many :phones, :class_name => 'Contact::Property::Phone',
    :foreign_key => :contact_contact_id, :dependent => :delete_all, :autosave => true
  accepts_nested_attributes_for :phones, :reject_if => :reject_empty_properties, :allow_destroy => true
  
  has_many :addresses, :class_name => 'Contact::Property::Address',
    :foreign_key => :contact_contact_id, :dependent => :delete_all, :autosave => true
  accepts_nested_attributes_for :addresses, :reject_if => :reject_empty_addresses, :allow_destroy => true

  has_and_belongs_to_many :groups, :class_name => 'Contact::Group', :foreign_key => :contact_contact_id,
    :association_foreign_key => :contact_group_id, :join_table => :contact_contacts_groups

  validates_associated :emails
  validates_associated :phones
  validates_associated :addresses
  validates_date :birthdate, :allow_blank => true

  def to_s
    "#{fullname} [id:#{id||'null'}]"
  end

  def main_email
    emails.first
  end

  def main_phone
    phones.first
  end

  protected
    def reject_empty_properties prop
      prop[:value].strip.blank?
    end

    def reject_empty_addresses address
      address[:street].strip.blank?
    end
end
