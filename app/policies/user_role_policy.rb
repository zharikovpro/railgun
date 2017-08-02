class UserRolePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all if user.administrator?
    end
  end

  def create?
    user.administrator?
  end

  alias_method :index?, :create?
  alias_method :show?, :create?
  alias_method :destroy?, :create?

  def permitted_attributes
    [:user_id, :role]
  end
end
