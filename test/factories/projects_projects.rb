# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projects_project, :class => 'Projects::Project' do
    title "MyString"
    description "MyText"
    start_date "2013-04-17"
    end_date "2013-04-17"
  end
end
