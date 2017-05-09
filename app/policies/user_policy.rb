class UserPolicy < ApplicationPolicy
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
  alias_method :update?, :create?

  def permitted_attributes
    [:email, :password, :password_confirmation]
  end
end
