require 'spec_helper'

describe Projects::TaskStatus do
  it "should have label as label_field" do
    Projects::TaskStatus.label_field.should eql :label
  end

  it "should have in label the concat of percent and value" do
    status = Projects::TaskStatus.new
    status.value = "Finished"
    status.percent = "100"
    status.label.should eql "100% - Finished"
  end
  
  describe "status of work done or not" do
    subject { task }
    context "with percent < 10" do
      let(:task) { FactoryGirl.create('projects/task_status', :percent => 5) }
      it { should_not be_work_started }
      it { should_not be_work_finished }
    end
    context "with percent >= 10 and <= 90" do
      let(:task) { FactoryGirl.create('projects/task_status', :percent => 20) }
      it { should be_work_started }
      it { should_not be_work_finished }
    end
    context "with percent > 90" do
      let(:task) { FactoryGirl.create('projects/task_status', :percent => 91) }
      it { should be_work_started }
      it { should be_work_finished }
    end
  end
end
