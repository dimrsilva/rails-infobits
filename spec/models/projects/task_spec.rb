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

  let(:default_status) { FactoryGirl.create('projects/task_status', :percent => 0) }
  let(:sprinted_status) { FactoryGirl.create('projects/task_status', :percent => 7) }
  let(:started_status) { FactoryGirl.create('projects/task_status', :percent => 11) }
  let(:finished_status) { FactoryGirl.create('projects/task_status', :percent => 100) }
  let(:task) { FactoryGirl.create('projects/task', :task_status => default_status) }

  describe "automated datetime updates" do
    let(:default_datetime) { DateTime.yesterday.beginning_of_day }
    let!(:now_datetime) { DateTime.now }

    before :each do
      DateTime.stub!(:now).and_return(now_datetime)
    end

    shared_examples_for "automated datetime" do |field|
      subject { task.send(field) }
      before :each do
        task.task_status = new_status
        task.save
      end

      context "with null datetime" do
        it { should_not be nil}
        it { should eql now_datetime}
      end

      context "with filled datetime" do
        let(:task) { FactoryGirl.create('projects/task',
          :task_status => default_status, field => default_datetime
        ) }
        
        it { should_not eql now_datetime }
        it { should eql default_datetime }
      end
    end

    context "changing to started_status" do
      it_behaves_like "automated datetime", :start_datetime do
        let(:new_status) { started_status }
      end
    end

    context "changing to finished_status" do
      it_behaves_like "automated datetime", :end_datetime do
        let(:new_status) { finished_status }
      end
    end

    context "changing to sprinted_status" do
      it_behaves_like "automated datetime", :sprint_datetime do
        let(:new_status) { sprinted_status }
      end
    end

    context "update without change status" do
      let(:task) { FactoryGirl.create('projects/task', :task_status => started_status) }
      subject { task.start_datetime }
      before :each do
        task.task_status = started_status
        task.save
      end

      it { should be nil }
      it { should_not eql now_datetime }
    end
  end

  describe "sprints" do
    let!(:t1) { FactoryGirl.create('projects/task', :task_status => finished_status) }
    let!(:t2) { FactoryGirl.create('projects/task', :task_status => started_status) }
    let!(:t3) { FactoryGirl.create('projects/task', :task_status => sprinted_status) }
    let!(:t4) { FactoryGirl.create('projects/task', :task_status => default_status) }

    describe "sprinted" do
      it "should return only with sprinted status" do
        Projects::Task.sprinted.count.should eql 3
        Projects::Task.sprinted.all.should eql [t1, t2, t3]
      end
    end

    describe "started" do
      it "should return only with started status" do
        Projects::Task.started.count.should eql 2
        Projects::Task.started.all.should eql [t1, t2]
      end
    end

    describe "finished" do
      it "should return only with finished status" do
        Projects::Task.finished.count.should eql 1
        Projects::Task.finished.all.should eql [t1]
      end
    end

    describe "of_sprint" do
      let(:before_datetime) { DateTime.new(2013,05,10).end_of_day }
      let(:start_datetime) { DateTime.new(2013,05,11).end_of_day }
      let(:between_datetime) { DateTime.new(2013,05,12).end_of_day }
      let(:end_datetime) { DateTime.new(2013,05,13).end_of_day }
      let(:after_datetime) { DateTime.new(2013,05,14).end_of_day }

      before :each do
        t1.sprint_datetime = between_datetime
        t1.save
        t2.sprint_datetime = before_datetime
        t2.save
        t3.sprint_datetime = end_datetime
        t3.save
        t4.end_datetime = start_datetime
        t4.save
      end

      it "should show all tasks with any_datetime in interval" do
        Projects::Task.of_sprint(start_datetime, end_datetime).count.should eql 3
      end
    end
  end
end
