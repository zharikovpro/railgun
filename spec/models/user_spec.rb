RSpec.describe User do
  it 'may have many roles', issues: ['railgun#54'] do
    is_expected.to have_many(:user_roles)
  end

  it '.roles returns array of role titles', issues: ['railgun#54'] do
    user = create(:user)
    UserRole.create(user: user, role: :support)
    UserRole.create(user: user, role: :editor)

    roles = user.roles

    expect(roles).to match_array([:support, :editor])
  end

  it '.add_role adds and returns associated UserRole', issues: ['railgun#54'] do
    user = create(:user)

    user.add_role(:editor)

    expect(user.roles).to include(:editor)
  end

  context 'has role' do
    it 'is employee', issues: ['railgun#76'] do
      user = create(:administrator)

      is_employee = user.employee?

      expect(is_employee).to be true
    end
  end

  context 'has no role' do
    it 'is not employee', issues: ['railgun#76'] do
      user = create(:user)

      is_employee = user.employee?

      expect(is_employee).to be false
    end
  end

  it 'Scope employee return only employee', issues: ['railgun#76'] do
    create(:user)
    create(:administrator)

    employees = User.employees

    expect(employees.count).to eq(1)
    expect(employees.first).to be_employee
  end

  it '.missing_roles returns missing user roles as array of symbols', issues: ['railgun#95'] do
    user = create(:editor)
    user.add_role(:developer)

    missing_roles = user.missing_roles

    expect(missing_roles).to contain_exactly(:owner, :administrator, :moderator, :support)
  end

  context 'can not create user', issues: ['railgun#169'] do
    it 'without password' do
      is_expected.to validate_presence_of :password
    end

    it 'without password_confirmation' do
      expect(build(:user, password_confirmation: '')).not_to be_valid
    end

    it 'if password not match password_confirmation' do
      expect(build(:user, password: 'Not', password_confirmation: 'Match')).not_to be_valid
    end
  end

  context 'Email validation' do
    it 'incorrect format', issues: ['railgun#175'] do
      expect(build(:user, email: 'not_format_email_string')).not_to be_valid
    end

    it 'correct format', issues: ['railgun#190'] do
      expect(build(:user, email: 'this correct format@email_string')).to be_valid
    end
  end
end
