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
    subject { FactoryGirl.create('projects/task_status', :percent => percent) }

    shared_examples_for "backlogged task" do
      it { should_not be_sprinted }
      it { should_not be_work_started }
      it { should_not be_work_finished }
    end
    shared_examples_for "sprinted task" do
      it { should be_sprinted }
      it { should_not be_work_started }
      it { should_not be_work_finished }
    end
    shared_examples_for "started task" do
      it { should be_sprinted }
      it { should be_work_started }
      it { should_not be_work_finished }
    end
    shared_examples_for "finished task" do
      it { should be_sprinted }
      it { should be_work_started }
      it { should be_work_finished }
    end


    context "with percent = 0" do
      let(:percent) { 0 }
      it_behaves_like "backlogged task"
    end
    context "with percent = 5" do
      let(:percent) { 5 }
      it_behaves_like "backlogged task"
    end
    context "with percent = 6" do
      let(:percent) { 6 }
      it_behaves_like "sprinted task"
    end
    context "with percent = 10" do
      let(:percent) { 10 }
      it_behaves_like "sprinted task"
    end
    context "with percent = 11" do
      let(:percent) { 11 }
      it_behaves_like "started task"
    end
    context "with percent = 90" do
      let(:percent) { 90 }
      it_behaves_like "started task"
    end
    context "with percent = 91" do
      let(:percent) { 91 }
      it_behaves_like "finished task"
    end
  end
end
