require_relative "../rails_helper.rb"
describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully logs in' do
    # binding.pry
    create_standard_user
    visit '/login'
    expect(current_path).to eq('/login')
    user_login
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

  it 'prevents user from viewing user show page and redirects to home page if not logged in' do
    create_standard_user
    visit '/users/1'
    expect(current_path).to eq('/')
  end

end