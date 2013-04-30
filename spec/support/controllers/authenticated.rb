shared_examples_for "Authenticated resource" do
  context "User is not authenticated" do
    subject do
      get :index
      response
    end
    it { should redirect_to new_user_session_path }
  end

  context "User is authenticated" do
    before :each do
      @user = FactoryGirl.create('admin/user')
      sign_in @user
    end

    subject do
      get :index
      response
    end
    it { should_not redirect_to new_user_session_path }
  end
end
