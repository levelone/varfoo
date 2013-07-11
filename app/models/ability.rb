class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new #guest

      if user.admin
        can :create, Article
        can :read, Article
        can :update, Article
        can :destroy, Article
        can :create, Comment
        can :read, Comment
        can :update, Comment
        can :destroy, Comment
      else
        can :read, Article
        can :create, Comment
      end
  	end
  end