class User < ApplicationRecord
  # consider using :lockable when user has financial transactions
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable

  validates_presence_of :email

  validates_presence_of :password, if: :password_required?
  #validate :password_match?, if: :password_required?

  has_many :user_roles
  accepts_nested_attributes_for :user_roles, allow_destroy: true

  scope :employees, -> { joins(:user_roles).distinct }

  # TODO: def timeout_in
  #   if employee?
  #     30.minutes
  #   else
  #     7.days
  #   end
  # end

  # TODO: def confirmation_required?
  #   employee?
  # end
  def available_roles(user_id)
    UserRole::TITLES - User.find_by_id(user_id).roles
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

  def password_required?
    # Password is required if it is being set, but not for new records
    if persisted?
      !password.nil? || !password_confirmation.nil?
    else
      false
    end
  end

  # def password_match?
  #   self.errors[:password] << 'cannot be blank' if password.blank?
  #   self.errors[:password_confirmation] << 'cannot be blank' if password_confirmation.blank?
  #   self.errors[:password_confirmation] << 'does not match' if password != password_confirmation
  #   password.present? && password == password_confirmation
  # end
end
