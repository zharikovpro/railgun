class SnippetPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

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
    [:slug, :text]
  end
end
