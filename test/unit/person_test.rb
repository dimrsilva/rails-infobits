require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "person has contact fullname attr" do
    company = Person.first
    assert company.fullname
  end
end
