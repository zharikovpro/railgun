class UserRolePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.administrator?
        scope.all
      end
    end
  end

  def index?
    user.administrator?
  end

  def create?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end

  def show?
    user.administrator?
  end
end
