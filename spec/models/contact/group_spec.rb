require 'spec_helper'

describe Contact::Group do

  before :each do
    @group = FactoryGirl.build("contact/group")
  end

  it "should have error when deleting group with contacts" do
    @group.save
    id = @group.id
    @contact = FactoryGirl.create("contact/contact")
    @contact.groups << @group
    @contact.save

    @group.destroy.should eql false
    @group.errors.count.should eql 1
    Contact::Group.find(id).should eql @group
  end
end
