# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= Employee.new # guest user (not logged in)
    if user.role? :admin
        can :manage, :all
    elsif user.role? :manager
        #can :manage, :all
        can :manage, Shift
        can :manage, ShiftJob
        can :index, Job
        can :index, Employee
        can :index, Assignment
        can :index, Store
        can :show, Job
        # # can :show, Assignment do |a|
        # #     assignments = Assignment.current.for_store(user.current_assignment.store).map{|a| a.id}
        # #     assignments.include?{a.id}
        # #     # a.each do |i|
        # #     #     if a.i == a.id
        # #     #         ans = true
        # #     #         return true
        # #     #     end
        # #     # end
        # #     # return a
        # # end
        # can :show, Employee do |e|
        #     user.current_assignment.store.id == e.current_assignment.store.id
        # end
        # can :update, Employee do |e|
        #     user.current_assignment.store.id == e.current_assignment.store.id
        # end
        # can :edit, Employee do |e|
        #     user.current_assignment.store.id == e.current_assignment.store.id
        # end
        
    elsif user.role? :employee
        can :index, Assignment
        can :show, Employee, id: user.id
        can :edit, Employee, id: user.id
        can :update, Employee, id: user.id
        #can :read, Employee, id: user.id
        can :read, Assignment do |a|
            user.id == a.employee.id
        end
        can :show, Assignment do |a|
            user.id == a.employee.id
        end
        # can :read, Shift, id: Shift.for_employee(user.id)
        # can :show, Shift, id: Shift.for_employee(user.id)
        #can :manage, :all
    end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
