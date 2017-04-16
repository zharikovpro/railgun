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
      @user = user
      @scope = scope
    end
  end
end
