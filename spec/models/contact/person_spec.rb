require 'spec_helper'

describe Contact::Person do

  before(:each) do
    @person = Contact::Person.new
  end

  it "should have contact attributes" do
    expect {
      @person.fullname
    }.to_not raise_error NoMethodError
  end

  it "should be invalid without firstname" do
    @person.should_not be_valid
  end

  it "should set contact fullname attribute" do
    @person.firstname = 'Anderson'
    @person.fullname.should eql 'Anderson'

    @person.prefix = 'Sir.'
    @person.fullname.should eql 'Sir. Anderson'

    @person.lastname = 'e Silva'
    @person.fullname.should eql 'Sir. Anderson e Silva'

    @person.middlename = 'Ribeiro'
    @person.fullname.should eql 'Sir. Anderson Ribeiro e Silva'
  end
end
