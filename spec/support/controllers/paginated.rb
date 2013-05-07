shared_examples_for "Paginated resource" do
  before :each do
    @model = controller.send(:get_model)
    sign_in_administrator
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
end
