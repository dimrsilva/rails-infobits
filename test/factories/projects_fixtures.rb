# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projects_fixture, :class => 'Projects::Fixture' do
    title "MyString"
    color "MyString"
    project_id 1
  end
end
