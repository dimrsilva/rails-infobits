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

  it "should validate color" do
    status = Projects::TaskStatus.new

    status.color = '345'
    status.should be_valid

    status.color = '123456'
    status.should be_valid

    status.color = '#FFAAVV'
    status.should_not be_valid

    status.color = '#FFAACC'
    status.should_not be_valid
  end
end
