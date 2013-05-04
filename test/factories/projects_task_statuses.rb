# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projects_task_status, :class => 'Projects::TaskStatus' do
    type ""
    percent 1
  end
end
