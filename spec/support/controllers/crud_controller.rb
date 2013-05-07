shared_examples_for "Crud resource" do

  before :each do
    @model = controller.send(:get_model)
    sign_in_administrator
  end

  let!(:row) do
    FactoryGirl.create(controller.send(:get_model).model_name.underscore)
  end

  let(:get_index_action) do
    [:index]
  end

  let(:get_new_action) do
    [:new]
  end

  let(:get_edit_action) do
    [:edit, {:id => row.id}]
  end

  let(:get_show_action) do
    [:show, {:id => row.id}]
  end

  context "accessing data (GET)" do
    context "GET /index" do
      subject do
        send :get, *get_index_action
        response
      end
      it { should be_success }
    end
    context "GET /new" do
      subject do
        send :get, *get_new_action
        response
      end
      it { should be_success }
    end
    context "GET /edit" do
      subject do
        send :get, *get_edit_action
        response
      end
      it { should be_success }
    end
    # context "GET /show" do
    #   subject do
    #     send :get, *get_show_action
    #     response
    #   end
    #   it { should be_success }
    # end

    it "should filter results"
  end

  context "accessing unavailable data (GET)" do
    it "should show 404 error" do
      @model.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
      get :edit, :id => 1
      response.response_code.should eql 404 
      # get :show, :id => 1
      # response.response_code.should eql 404 
      post :update, :id => 1
      response.response_code.should eql 404 
      post :destroy, :id => 1
      response.response_code.should eql 404 
    end
  end

  context "submitting data (POST)" do
    context "with valid input" do
      before :each do
        @model.any_instance.stub(:valid?).and_return(true)
      end

      it "should insert and redirect to edit page" do
        post :create
        assigns[:row].should_not be_new_record
        response.should redirect_to :action => :edit, :id => assigns[:row].id
      end

      it "should update and redirect to edit page" do
        post :update, :id => row.id
        response.should redirect_to :action => :edit, :id => assigns[:row].id
      end

      it "should redirect to index after destroying" do
        post :destroy, :id => row.id
        response.should redirect_to :action => :index
      end
    end

    context "with invalid input" do
      before :each do
        @model.any_instance.stub(:valid?).and_return(false)
      end

      it "should not insert or redirect" do
        post :create
        assigns[:row].should be_new_record
        response.should_not redirect_to :action => :show, :id => assigns[:row].id
      end

      it "should not update and redirect to show page" do
        post :update, :id => row.id
        response.should_not redirect_to :action => :show, :id => assigns[:row].id
      end
    end
  end
end
