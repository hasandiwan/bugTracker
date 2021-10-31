require 'rails_helper'

Rspec.describe Role, type: :model do
  let(:role) {
    Role.create(name: "Developer")
  }

  it "is valid with a name" do
    expect(role).to be_valid
  end


end