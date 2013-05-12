# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_action_log, :class => 'System::ActionLog' do
    time "2013-05-12 15:23:02"
    affected_type "MyString"
    affected_id ""
    linkable_type "MyString"
    linkable_id 1
    user_id 1
  end
end
