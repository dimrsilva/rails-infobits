class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if user.administrator? or user.email == 'dimrsilva@gmail.com'
      # Yes, I can do everything, MUHAHSAUSHUAHU
      can :manage, :all
    elsif user.project_director?
      can :read, Contact::Contact
      can :manage, Projects::Project
      can :manage, Projects::Task
    elsif user.project_manager?
      can :read, Contact::Contact
      can :create, Projects::Project
      can :manage, Projects::Project, :manager => user.contact
      can :manage, Projects::Task do |task|
        task.project.manager == user.contact
      end
    elsif user.colaborator?
      # can :change_status, Projects::Task, :responsible => user.contact
      can :read, Projects::Project do |project|
        project.colaborators.include? user.contact
      end
      can :read, Projects::Task do |task|
        task.project.colaborators.include? user.contact
      end
      can :update, Projects::Task, :responsible => user.contact
    end
  end
end
