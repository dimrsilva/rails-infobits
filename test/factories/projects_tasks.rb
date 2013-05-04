# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projects_task, :class => 'Projects::Task' do
    title "MyString"
    description "MyText"
    estimated_time 1
    real_time 1
  end
end
