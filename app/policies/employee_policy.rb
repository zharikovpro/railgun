class EmployeePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || (user == record)
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
