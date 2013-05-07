require 'spec_helper'

describe Admin::User do

  before :each do
    @user = Admin::User.new
  end

  it "should validate email" do
    @user.email = 'dfdjsf@jfsk@#'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email)
    @user.email = 'test@example.com'
    @user.should be_valid
  end

  it "should have unique emails" do
    Admin::User.create email: 'a@b.com', password: '1', password_confirmation: '1'
    @user.email = 'a@b.com'
    @user.password = '2'
    @user.password_confirmation = '2'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email)
  end

  it "should confirm password" do
    @user.password = 'test'
    @user.password_confirmation = ''
    @user.should_not be_valid
    @user.should have(1).errors_on(:password)

    @user.password = 'test'
    @user.password_confirmation = 'test'
    @user.should_not be_valid #cause is missing email
    @user.should have(:no).errors_on(:password)
  end

  it "should require email field" do
    @user.should_not be_valid
    @user.should have(1).errors_on(:email) #required
    @user.email = 'invalid email'
    @user.should_not be_valid
    @user.should have(1).errors_on(:email) #invalid email
  end

  it "should not update password if empty string is passed" do
    @user.email = 'test@example.com'
    @user.password = '123'
    @user.password_confirmation = '123'
    @user.should be_valid
    @user.save
    id = @user.id
    encrypted = @user.encrypted_password
    @user.password = ''
    @user.password_confirmation = '';
    @user.save
    @user = Admin::User.find id
    @user.encrypted_password.should eql encrypted
  end

  context "checking roles" do
    let(:group_administrator) { Contact::Group.create(:acts_as_administrator => true) }
    let(:group_colaborator) { Contact::Group.create(:acts_as_colaborator => true) }
    let(:contact) { Contact::Person.create }
    let(:user) { Admin::User.create(
      :contact => contact,
      :email => 'test@example.com',
      :password => '123'
    ) }

    subject { user }

    context "user in administrator group" do
      before :each do
        contact.groups << group_administrator
      end
      it { should be_administrator }
      it { should_not be_colaborator }
    end
    context "user in administrator and colaborator group" do
      before :each do
        contact.groups << group_administrator
        contact.groups << group_colaborator
      end
      it { should be_administrator }
      it { should be_colaborator }
    end
    context "user in colaborator and administrator group" do
      before :each do
        contact.groups << group_colaborator
        contact.groups << group_administrator
      end
      it { should be_administrator }
      it { should be_colaborator }
    end
  end


  it "should not raise error when have no contact and try to check permissions" do
    @user = Admin::User.new
    expect {
      @user.administrator?
    }.to_not raise_error NoMethodError
  end
end
