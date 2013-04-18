shared_examples_for CrudController do

  before :each do
    @model = controller.send(:get_model)
  end

  context "User is not authenticated" do
    it "should require authentication" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  context "User is authenticated" do
    before :each do
      @model.any_instance.stub(:valid?).and_return(true)
      Admin::User.any_instance.stub(:valid?).and_return(true)
      @user = Admin::User.create :email => "test@example.com"
      sign_in @user
    end

    it "should not redirect to authentication page" do
      get :index
      response.should_not redirect_to new_user_session_path
    end

    context "accessing data (GET)" do
      it "should be successful when GET /" do
        get :index
        response.should be_success
      end

      it "should be successful when GET /new" do
        get :new
        assigns[:row].should be_new_record
        response.should be_success
      end

      it "should be successful when GET /$id" do
        @row = @model.new
        @row.save
        get :edit, :id => @row.id
        assigns[:row].should_not be_new_record
        response.should be_success
      end

      it "should paginate rows on index" do
        15.times do
          @row = FactoryGirl.create(@model.model_name.underscore)
          @row.should_not be_new_record
        end
        @model.all.count.should eql 15
        get :index
        assigns[:list].length.should eql 10
        get :index, :page => 2
        assigns[:list].length.should eql 5
      end

      it "should filter results"
    end

    context "accessing unavailable data (GET)" do
      it "should show 404 error" do
        @model.stub!(:find).and_raise(ActiveRecord::RecordNotFound)
        get :edit, :id => 1
        response.response_code.should eql 404 
        get :show, :id => 1
        response.response_code.should eql 404 
        post :update, :id => 1
        response.response_code.should eql 404 
        post :destroy, :id => 1
        response.response_code.should eql 404 
      end
    end

    context "submitting data (POST)" do
      context "with valid input" do
        it "should insert and redirect to show page" do
          post :create
          assigns[:row].should_not be_new_record
          response.should redirect_to :action => :show, :id => assigns[:row].id
        end

        it "should update and redirect to show page" do
          @row = @model.new
          @row.save
          post :update, :id => @row.id
          response.should redirect_to :action => :show, :id => assigns[:row].id
        end

        it "should redirect to index after destroying" do
          @row = @model.new
          @row.save
          post :destroy, :id => @row.id
          response.should redirect_to :action => :index
        end
      end

      context "with invalid input" do
        before :each do
          @row = @model.new
          @row.save
          @model.any_instance.stub(:valid?).and_return(false)
        end

        it "should not insert or redirect" do
          post :create
          assigns[:row].should be_new_record
          response.should_not redirect_to :action => :show, :id => assigns[:row].id
        end

        it "should not update and redirect to show page" do
          post :update, :id => @row.id
          response.should_not redirect_to :action => :show, :id => assigns[:row].id
        end
      end
    end
  end
end
