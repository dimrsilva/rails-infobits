require 'test_helper'

class Contact::CompanyTest < ActiveSupport::TestCase
  test "company has contact fullname attr" do
  	company = Contact::Company.first
  	assert company.fullname
  end

  test "fullname has changed after changing fantasy_name" do
    c = Contact::Company.new
    c.fantasy_name = 'Festa & Festas Eventos'
    assert c.fullname == 'Festa & Festas Eventos'
  end
end
