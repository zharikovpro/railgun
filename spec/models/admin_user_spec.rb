describe AdminUser do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
