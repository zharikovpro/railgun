class UserPolicy < ApplicationPolicy
  def create?
    user.administrator?
  end
end
