class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def new?
    false
  end

  def create?
    false
  end

  def show?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
