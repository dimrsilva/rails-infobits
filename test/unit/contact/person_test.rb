require 'test_helper'

class Contact::PersonTest < ActiveSupport::TestCase
  test "person has contact fullname attr" do
    person = Contact::Person.first
    assert person.fullname
  end

  test "fullname has changed after changing partial names" do
    person = Contact::Person.new
    person.firstname = 'Anderson'
    assert person.fullname == 'Anderson'
    person.prefix = 'Sir.'
    assert person.fullname == 'Sir. Anderson'
    person.lastname = 'e Silva'
    assert person.fullname == 'Sir. Anderson e Silva'
    person.middlename = 'Ribeiro'
    assert person.fullname == 'Sir. Anderson Ribeiro e Silva'
  end
end
