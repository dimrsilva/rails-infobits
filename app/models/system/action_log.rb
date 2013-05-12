class System::ActionLog < ActiveRecord::Base
  belongs_to :affected, :polymorphic => true
  belongs_to :linked, :polymorphic => true
  belongs_to :user, :class_name => 'Admin::User', :foreign_key => :user_id
end
