class User < ApplicationRecord
  # consider using :lockable when user has financial transactions
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :validatable

  has_many :user_roles, dependent: :destroy
  accepts_nested_attributes_for :user_roles, allow_destroy: true
  alias_method :authenticate, :valid_password?
  scope :employees, -> { joins(:user_roles).distinct }

  if Rails.env.development?
    def password_required?
      instance_variable_set('@dev_user', User.find_by_email(email))
      true
    end
  end

  def timeout_in
    if employee?
      5.minutes
    else
      7.days
    end
  end

  def missing_roles
    UserRole::TITLES - roles
  end

  def add_role(title)
    UserRole.create(user: self, role: title)
  end

  def roles
    user_roles.pluck(:role).map(&:to_sym)
  end

  def employee?
    roles.present?
  end

  def administrator?
    roles.include?(:administrator)
  end

  def developer?
    roles.include?(:developer)
  end

  def editor?
    roles.include?(:editor)
  end

  def api_token
    Knock::AuthToken.new(payload: { sub: id }).token
  end
end
