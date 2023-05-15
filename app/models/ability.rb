# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.organization_admin?
      can :manage, Post
    else
      can :read, Post
    end
  end

end
