require 'test_helper'

class Contact::PersonTest < ActiveSupport::TestCase
  test "person has contact fullname attr" do
    company = Contact::Person.first
    assert company.fullname
  end
end
