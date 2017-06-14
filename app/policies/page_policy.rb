class PagePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.editor?
  end

  alias_method :index?, :create?
  alias_method :update?, :create?
  alias_method :destroy?, :create?

  def permitted_attributes
    [:slug, :markdown]
  end
end
