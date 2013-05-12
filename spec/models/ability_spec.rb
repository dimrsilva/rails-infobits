require 'spec_helper'
require "cancan/matchers"

describe Ability do
  let(:group_administrator) do
    @group = Contact::Group.new
    @group.acts_as_administrator = true
    @group.save
    @group
  end

  let(:group_project_director) do
    @group = Contact::Group.new
    @group.acts_as_project_director = true
    @group.save
    @group
  end

  let(:group_project_manager) do
    @group = Contact::Group.new
    @group.acts_as_project_manager = true
    @group.save
    @group
  end

  let(:group_colaborator) do
    @group = Contact::Group.new
    @group.acts_as_colaborator = true
    @group.save
    @group
  end
  let(:contact) { Contact::Person.create!(:firstname => 'Test') }
  let(:ability) { Ability.new(user) }
  let(:user) do
    Admin::User.create!(
      :email => 'test@example.com',
      :password => '123',
      :contact => contact
    )
  end

  subject { ability }

  context "user is administrator" do
    before :each do
      contact.groups << group_administrator
    end
    it { should be_able_to :manage, :all }
  end

  context "user is project director" do
    before :each do
      contact.groups << group_project_director
    end
    it { should be_able_to :manage, Projects::Project }
    it { should be_able_to :manage, Projects::Task }
    it { should_not be_able_to :manage, Admin::User }
  end

  context "user is project manager" do
    before :each do
      contact.groups << group_project_manager
    end
    it { should be_able_to :create, Projects::Project }
    it { should_not be_able_to :manage, Admin::User }

    let(:project) { Projects::Project.create }
    let(:task) do
      t = Projects::Task.new
      t.project = project
      t.save
      t
    end

    context "with own project" do
      before :each do
        project.manager = contact
      end
      it { should be_able_to :manage, project }
      it { should be_able_to :manage, task }
    end

    context "with project owned by another person" do

      it { should_not be_able_to :manage, project }
      it { should_not be_able_to :read, project }
      it { should_not be_able_to :update, project }
      it { should_not be_able_to :destroy, project }
      it { should_not be_able_to :update, task }
      it { should_not be_able_to :create, task }
      it { should_not be_able_to :read, task }
      it { should_not be_able_to :destroy, task }
    end
  end

  context "user is colaborator" do
    before :each do
      contact.groups << group_colaborator
    end

    let(:task) do
      p = Projects::Task.new
      p.project = project
      return p
    end
    let(:project) { Projects::Project.create }

    it { should_not be_able_to :manage, Projects::Project }
    it { should be_able_to :read, Projects::Project }
    it { should_not be_able_to :update, Projects::Project }
    it { should_not be_able_to :destroy, Projects::Project }

    it { should be_able_to :read, Projects::Task }
    it { should be_able_to :change_status, Projects::Task }
    it { should_not be_able_to :update, Projects::Task }
    it { should_not be_able_to :create, Projects::Task }
    it { should_not be_able_to :destroy, Projects::Task }

    context "with project which he is a colaborator" do
      before :each do
        project.colaborators << contact
      end
      it { should be_able_to :read, project }
      it { should_not be_able_to :update, project }

      context "with task which he is the responsible" do
        before :each do
          task.responsible = contact
        end

        it { should be_able_to :read, task }
        it { should be_able_to :change_status, task }
        it { should_not be_able_to :update, task }
        it { should_not be_able_to :destroy, task }
      end

      context "with task which he is not the responsible" do
        it { should be_able_to :read, task }
        it { should_not be_able_to :change_status, task }
        it { should_not be_able_to :update, task }
        it { should_not be_able_to :destroy, task }
      end
    end

    context "with project which he is not a colaborator" do
      it { should_not be_able_to :manage, project }
      it { should_not be_able_to :read, project }
      it { should_not be_able_to :update, project }
      it { should_not be_able_to :destroy, project }
      it { should_not be_able_to :manage, task }
      it { should_not be_able_to :read, task }
      it { should_not be_able_to :update, task }
      it { should_not be_able_to :destroy, task }
    end
  end
end
