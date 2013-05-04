shared_examples_for "Authenticated resource" do
  let :get_example do
    get :index
    response
  end

  context "User is not authenticated" do
    subject { get_example }
    it { should redirect_to new_user_session_path }
  end

  context "User is authenticated" do
    before :each do
      @user = FactoryGirl.create('admin/user')
      sign_in @user
    end

    subject { get_example }
    it { should_not redirect_to new_user_session_path }
  end
end
