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

end
