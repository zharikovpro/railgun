class UserPolicy < ApplicationPolicy
  def create?
    user.administrator?
  end

  def update?
    user.administrator?
  end
end
