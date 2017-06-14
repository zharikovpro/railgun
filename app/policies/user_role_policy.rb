class UserRolePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.administrator?
        scope.all
      end
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
