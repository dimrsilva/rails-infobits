require 'spec_helper'

describe Contact::Contact do

  before :each do
    @contact = Contact::Contact.new
  end

  it "should accept emails on mass assignment" do
    mass_assign = { :emails_attributes => [{:value => 'test@example.com'}]}
    @contact.attributes = mass_assign
    @contact.emails.length.should eql 1
  end

  it "should accept phones on mass assignment" do
    mass_assign = { :phones_attributes => [{:value => '3222 0533'}]}
    @contact.attributes = mass_assign
    @contact.phones.length.should eql 1
  end

  it "should accept addresses on mass assignment" do
    mass_assign = { :addresses_attributes => [{:street => 'Street Test', :country => 'BR'}]}
    @contact.attributes = mass_assign
    @contact.addresses.length.should eql 1
  end

  it "should accept group ids on mass assignment" do
    mock_model Contact::Group
    groups = [
      stub_model(Contact::Group, :id => 1, :note => "Test"),
      stub_model(Contact::Group, :id => 2, :note => "Test 2"),
    ]
    Contact::Group.stub!(:find).with([1, 2]).and_return(groups)

    mass_assign = {:group_ids => [1, 2]}
    @contact.attributes = mass_assign
    @contact.groups.length.should eql 2
  end

  it "should return fullname with id when called to_s" do
    @contact.stub!(:fullname).and_return("Maria Pereira")
    @contact.to_s.should eql "Maria Pereira [id:null]"
    @contact.save
    @contact.to_s.should eql "Maria Pereira [id:#{@contact.id}]"
  end

  it "should has main_email" do
    @email = Contact::Property::Email.create(:value => 'test@example.com')
    @contact.emails << @email
    @contact.main_email.should be @email
  end

  it "should has main_phone" do
    @phone = Contact::Property::Phone.create(:value => '32123456')
    @contact.phones << @phone
    @contact.main_phone.should be @phone
  end
end
