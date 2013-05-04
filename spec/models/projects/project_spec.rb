require 'spec_helper'

describe Projects::Project do
  it "should require status" do
    @project = Projects::Project.new
    @project.should_not be_valid
    @status = Projects::Status.new
    @project.status = @status
    @project.should be_valid
  end
end
