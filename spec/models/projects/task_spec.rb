require 'spec_helper'

describe Projects::Task do
  it "should filter roots scope" do
    t1 = FactoryGirl.create('projects/task')
    t2 = FactoryGirl.create('projects/task')
    t3 = FactoryGirl.create('projects/task')
    t2.parent_task = t1
    t2.save

    Projects::Task.roots.all.should eql [t1, t3]
    t1.children_tasks.should eql [t2]
  end

  describe "automated datetime updates" do
    let(:default_status) { FactoryGirl.create('projects/task_status', :percent => 0) }
    let(:start_status) { FactoryGirl.create('projects/task_status', :percent => 1) }
    let(:end_status) { FactoryGirl.create('projects/task_status', :percent => 100) }
    let(:task) { FactoryGirl.create('projects/task', :task_status => default_status) }

    let(:default_datetime) { DateTime.yesterday.beginning_of_day }
    let!(:now_datetime) { DateTime.now }

    before :each do
      DateTime.stub!(:now).and_return(now_datetime)
    end

    context "changing to start_status" do
      subject { task.start_datetime }
      before :each do
        task.task_status = start_status
        task.save
      end

      context "with null start_datetime" do
        it { should_not be nil}
        it { should eql now_datetime}
      end

      context "with filled start_datetime" do
        let(:task) { FactoryGirl.create('projects/task',
          :task_status => default_status, :start_datetime => default_datetime
        ) }
        
        it { should_not eql now_datetime }
        it { should eql default_datetime }
      end
    end

    context "changing to end_status" do
      subject { task.end_datetime }
      before :each do
        task.task_status = end_status
        task.save
      end

      context "with null start_datetime" do
        it { should_not be nil }
        it { should eql now_datetime}
      end

      context "with filled start_datetime" do
        let(:task) { FactoryGirl.create('projects/task',
          :task_status => default_status, :end_datetime => default_datetime
        ) }

        it { should_not eql now_datetime }
        it { should eql default_datetime }
      end
    end

    context "update without change status" do
      let(:task) { FactoryGirl.create('projects/task', :task_status => start_status) }
      subject { task.start_datetime }
      before :each do
        task.task_status = start_status
        task.save
      end

      it { should be nil }
      it { should_not eql now_datetime }
    end
  end
end
