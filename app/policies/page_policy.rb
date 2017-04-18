class PagePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.developer?
        scope.all
      end
    end
  end

  def index?
    user.developer?
  end

  def create?
    user.developer?
  end

  def show?
    user.developer?
  end

  def update?
    user.developer?
  end

  def permitted_attributes
    [:slug, :markdown]
  end
end
