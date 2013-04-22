FactoryGirl.define do

  factory 'contact/contact'

  factory 'contact/person'

  factory 'contact/company'

  factory 'contact/email'
  factory 'contact/phone'
  factory 'contact/address'

  factory 'projects/project'
  factory 'projects/status'

  factory 'contact/group' do
    sequence(:name) { |n| "Group #{n}" }
  end

  factory 'admin/user' do
    email    'email@example.com'
    password '142$de'
  end
end