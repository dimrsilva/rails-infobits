require 'spec_helper'

describe Contact::Company do

  before :each do
    @company = Contact::Company.new
  end

  it "should have contact attributes" do
    expect {
      @company.fullname
    }.to_not raise_error NoMethodError
  end

  it "should be invalid without fantasy_name" do
    @company.should_not be_valid
  end

  it "should set contact fullname attribute" do
    @company.fantasy_name = 'XYZ Corporation'
    @company.fullname.should eql 'XYZ Corporation'
  end
end
