class ApplicationPolicy
  # Default deny stance:
  # specify only what you allow
  # and prohibit everything else.
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
  
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.administrator?
        scope.all
      end
    end
  end
  # def scope
  #   Pundit.policy_scope!(user, record.class)
  # end
  #
end
