require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully logs in' do
    create_admin_user
    visit '/'
    expect(current_path).to eq('/')
    admin_user_login
    expect(current_path).to eq('/users/1')
    expect(page).to have_content("Ash")
    expect(page).to have_content("Ketchup")
    expect(page).to have_content("Admin")
    expect(page).to have_content("ash@ketchup.com")
  end

  #TODO: Figure out this test
  # it "on log in, successfully adds a session hash" do
  #   create_standard_user
  #   visit '/login'
  #   # user_login method is defined in login_helper.rb
  #   user_login
  #   expect(page.get_rack_session_key('user_id')).to_not be_nil
  # end

  it 'prevents not logged user from viewing users index and show page and redirects to home page if not logged in' do
    create_standard_and_admin_user
    visit '/users/1'
    expect(current_path).to eq('/')
    visit "/users"
    expect(current_path).to eq('/')
  end

  it 'prevents non-admin user from viewing a user page other than itself and users index' do
    create_standard_and_admin_user
    visit '/'
    standard_user_login
    visit "/users/#{@misty.id + 1}"
    expect(current_path).to eq("/users/#{@misty.id}")
    visit "/users/"
    expect(current_path).to eq("/users/#{@misty.id}")
  end

  it 'admin user can view other users page and index' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit "/users/#{@ash.id + 1}"
    expect(current_path).to eq("/users/#{@ash.id.to_i + 1}")
    visit "/users"
    expect(current_path).to eq("/users")
  end

end