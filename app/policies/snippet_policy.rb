class SnippetPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.developer?
        scope.all
      end
    end
  end

  def show?
    true
  end

  def create?
    user.developer?
  end

  alias_method :index?, :create?
  alias_method :update?, :create?
  alias_method :destroy?, :create?

  def permitted_attributes
    [:slug, :text]
  end
end
