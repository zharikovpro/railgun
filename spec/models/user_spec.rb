RSpec.describe do
  it 'may have many roles', issues: [54] do
    it.is_expected.to have_many(:roles)
  end

  context 'has role' do
    it 'is employee', issues: [76] do
    	user = create(:administrator)

  		is_employee = user.employee?

  		expect(is_employee).to be true
		end
  end

  context 'has no role' do 
  	it 'is not employee' do
  		user = create(:user)

  		is_employee = user.employee?

  		expect(is_employee).to be false
  	end
  end

  it 'Scope employees return only employees', issues: [76] do
  	user = create(:user)
  	employee = create(:administrator)

  	expect(User.count != User.employees.count).to be true
  end
end
