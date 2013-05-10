shared_examples_for "Crud resource" do |resource_model|

  before :each do
    sign_in_administrator
  end

  let(:model) { resource_model }

  let!(:row) do
    FactoryGirl.create(model.model_name.underscore)
  end

  let(:row_attributes) { {model.label_field => 'Default Name'} }

  let(:get_index_action) { {:action => :index} }
  let(:get_new_action) { {:action => :new} }
  let(:get_edit_action) { {:action => :edit, :id => row.id} }
  let(:get_show_action) { { :action => :show, :id => row.id} }
  let(:post_create_action) { {:action => :create} }
  let(:put_update_action) { {:action => :update, :id => row.id} }
  let(:delete_destroy_action) { {:action => :destroy, :id => row.id} }

  it "should use correct model" do
    model.should be controller.send(:get_model)
  end

  context "accessing data (GET)" do
    subject { response }

    context "GET /index" do
      before :each do
        get *request_params(get_index_action) if get_index_action
      end
      it { should be_success if get_index_action }
    end
    context "GET /new" do
      before :each do
        get *request_params(get_new_action) if get_new_action
      end
      it { should be_success if get_new_action }
    end
    context "GET /edit" do
      before :each do
        get *request_params(get_edit_action) if get_edit_action
      end
      it { should be_success if get_edit_action }
    end
    context "GET /show" do
      before :each do
        get *request_params(get_show_action) if get_show_action
      end
      it { should be_success if get_show_action }
    end
  end

  context "accessing unavailable data (GET)" do
    subject { response.response_code }
    before :each do
      model.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
    end

    context "GET /edit" do
      before :each do
        get *request_params(get_edit_action) if get_edit_action
      end
      it { should eql 404 if get_edit_action }
    end
    context "GET /show" do
      before :each do
        get *request_params(get_show_action) if get_show_action
      end
      it { should eql 404 if get_show_action }
    end
    context "PUT /update" do
      before :each do
        put *request_params(put_update_action) if put_update_action
      end
      it { should eql 404 if put_update_action }
    end
    context "DELETE /destroy" do
      before :each do
        delete *request_params(delete_destroy_action) if delete_destroy_action
      end
      it { should eql 404 if delete_destroy_action }
    end
  end
end

shared_examples_for "Crud resource default behavior" do |resource_model|
  include_examples "Crud resource", resource_model

  context "submitting data (POST)" do
    context "with valid input" do
      before :each do
        model.any_instance.stub(:valid?).and_return(true)
      end
       it "should insert and redirect to edit page" do
        post *request_params(post_create_action)
        assigns[:row].should_not be_new_record
        response.should redirect_to get_edit_action.merge({:id => assigns[:row].id})
      end

      it "should update and redirect to edit page" do
        put *request_params(put_update_action)
        response.should redirect_to get_edit_action
      end

      it "should redirect to index after destroying" do
        delete *request_params(delete_destroy_action)
        response.should redirect_to get_index_action
      end
    end

    context "with invalid input" do
      before :each do
        model.any_instance.stub(:valid?).and_return(false)
      end

      it "should not insert or redirect" do
        post *request_params(post_create_action)
        assigns[:row].should be_new_record
        response.should_not redirect_to get_edit_action
      end

      it "should not update and redirect to show page" do
        put *request_params(put_update_action)
        response.should_not redirect_to get_edit_action
      end
    end
  end

end