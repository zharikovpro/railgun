class ReincarnationPolicy < ApplicationPolicy
  def create?
    user.admin? && record.confirmed?
  end
end
