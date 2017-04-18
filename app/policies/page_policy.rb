class PagePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.editor?
  end

  def create?
    user.editor?
  end

  def show?
    true
  end

  def update?
    user.editor?
  end

  def destroy?
    user.editor?
  end

  def permitted_attributes
    [:slug, :markdown]
  end
end
