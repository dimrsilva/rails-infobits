class Admin::User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :validatable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :contact

  belongs_to :contact, :class_name => "Contact::Contact", :foreign_key => :contact_id

  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates :email, :uniqueness => true, :presence => true

  validates :password, :confirmation => true

  def self.label_field
    :email
  end

  def administrator?
    check_role :acts_as_administrator
  end

  def project_director?
    check_role :acts_as_project_director
  end

  def project_manager?
    check_role :acts_as_project_manager
  end

  def colaborator?
    check_role :acts_as_colaborator
  end

  private
    def check_role attr
      if contact
        contact.groups.each do |group|
          if group.send(attr)
            return true
          end
        end
      end
      return false
    end
end
