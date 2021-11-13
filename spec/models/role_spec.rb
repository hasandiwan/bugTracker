require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) {
    Role.create(name: "Developer")
  }

  it "is valid with a name" do
    expect(role).to be_valid
  end
  
  it "has many users" do
    harold = User.create(
      first_name: "Harold", 
      last_name: "Torres", 
      role_id: role.id, 
      email: "harold@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(role.users.first).to eq(harold)
  end

end