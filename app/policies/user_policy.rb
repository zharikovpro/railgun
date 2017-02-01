class UserPolicy < EmployeePolicy
  def create?
    false
  end
end
