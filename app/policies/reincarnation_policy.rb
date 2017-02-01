class ReincarnationPolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end
