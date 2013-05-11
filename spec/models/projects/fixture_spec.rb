require 'spec_helper'

describe Projects::Fixture do
  describe "public methods" do
    subject { Projects::Fixture.new }
    it { should respond_to :title }
    it { should respond_to :color }
    it { should respond_to :project }
    it { should respond_to :tasks }
  end

  it "should delete with tasks" do
    fixture = FactoryGirl.create('projects/fixture')
    task = FactoryGirl.create('projects/task', :fixture => fixture, :project => fixture.project)

    fixture.destroy
    Projects::Task.all.count.should eql 1
    Projects::Task.find(task.id).fixture.should eql nil
  end

  it "should validate color" do
    fixture = Projects::Fixture.new

    fixture.color = '345'
    fixture.should be_valid

    fixture.color = '123456'
    fixture.should be_valid

    fixture.color = '#FFAAVV'
    fixture.should_not be_valid

    fixture.color = '#FFAACC'
    fixture.should_not be_valid
  end
end
