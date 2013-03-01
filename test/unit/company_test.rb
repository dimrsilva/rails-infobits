require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "company has contact fullname attr" do
  	company = Company.first
  	assert company.fullname
  end
end
