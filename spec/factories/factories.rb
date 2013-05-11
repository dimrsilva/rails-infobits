FactoryGirl.define do

  factory 'contact/contact'

  factory 'contact/person' do
    sequence(:firstname) { |n| "Person #{n}" }
  end
  factory 'contact/company' do
    sequence(:fantasy_name) { |n| "Company #{n}" }
  end

  factory 'contact/email'
  factory 'contact/phone'
  factory 'contact/address'

  factory 'projects/project' do
    association :status, :factory => 'projects/status'
  end
  factory 'projects/task' do
    association :project, :factory => 'projects/project'
  end
  factory 'projects/status'
  factory 'projects/task_status' do
    color 'ffffff'
  end

  factory 'contact/group' do
    sequence(:name) { |n| "Group #{n}" }
  end

  factory 'admin/user' do
    email    'email@example.com'
    password '123'
  end
end