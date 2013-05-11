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
end
