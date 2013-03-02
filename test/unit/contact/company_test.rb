require 'test_helper'

class Contact::CompanyTest < ActiveSupport::TestCase
  test "company has contact fullname attr" do
  	company = Contact::Company.first
  	assert company.fullname
  end
end
