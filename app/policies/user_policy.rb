class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.administrator?
        scope.all
      end
    end
  end

  def create?
    user.administrator?
  end

  def update?
    user.administrator?
  end
end
