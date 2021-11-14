require_relative "../rails_helper.rb"
describe 'Feature Test: User Log in and Log out', :type => :feature do

  it 'successfully logs in' do
    create_admin_user
    visit '/'
    expect(current_path).to eq('/')
    admin_user_login
    expect(current_path).to eq("/users/#{@ash.id}")
    expect(page).to have_content("Ash")
    expect(page).to have_content("Ketchup")
    expect(page).to have_content("Admin")
    expect(page).to have_content("ash@ketchup.com")
  end

  #TODO: Figure out this test
  # it "on log in, successfully adds a session hash" do
  #   create_admin_user
  #   visit '/'
  #   # user_login method is defined in login_helper.rb
  #   admin_user_login
  #   expect(page.get_rack_session_key('user_id')).to_not be_nil
  # end

  it 'prevents not logged user from viewing users index and show page and redirects to home page if not logged in' do
    create_standard_and_admin_user
    visit '/users/1'
    expect(current_path).to eq('/')
    visit "/users"
    expect(current_path).to eq('/')
  end

  it 'has a link to log out from the navigation bar and it redirects to home page after logging out ' do
    create_standard_and_admin_user
    visit '/'
    standard_user_login
    expect(page).to have_content("Log out")
    click_link("Log out")
    expect(current_path).to eq('/')
  end

  #TODO: Figure out this test
  # it "successfully destroys session hash when 'Log Out' is clicked" do
  #   create_standard_and_admin_user
  #   visit '/'
  #   standard_user_login
  #   click_link("Log out")
  #   expect(page.get_rack_session).to_not include("user_id")
  # end

end

describe 'Feature Test: User Flow', :type => :feature do

  it 'admin user can view other users page and index' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit "/users/#{@ash.id + 1}"
    expect(current_path).to eq("/users/#{@ash.id.to_i + 1}")
    visit "/users"
    expect(current_path).to eq("/users")
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

  it 'admin users nav bar includes Dashboard, Users, Projects, Tickets, My profile and Log out' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit '/'
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("Projects")
    expect(page).to have_content("Tickets")
    expect(page).to have_content("My profile")
    expect(page).to have_content("Log out")
    expect(page).to have_content("Users")
  end

  it 'non-admin users nav bar includes My Projects, My Tickets, My profile and Log out' do
    create_project_manager_user
    create_lead_developer_user
    create_developer_user
    visit '/'
 
    project_manager_user_login
    visit '/'
    expect(page).to_not have_content("Dashboard")
    expect(page).to have_content("My projects")
    expect(page).to have_content("My tickets")
    expect(page).to have_content("My profile")
    expect(page).to have_content("Log out")
    expect(page).to_not have_content("Users")
    visit '/logout'

    lead_developer_user_login
    visit '/'
    expect(page).to_not have_content("Dashboard")
    expect(page).to have_content("My projects")
    expect(page).to have_content("My tickets")
    expect(page).to have_content("My profile")
    expect(page).to have_content("Log out")
    expect(page).to_not have_content("Users")
    visit '/logout'

    developer_user_login
    visit '/'
    expect(page).to_not have_content("Dashboard")
    expect(page).to have_content("My projects")
    expect(page).to have_content("My tickets")
    expect(page).to have_content("My profile")
    expect(page).to have_content("Log out")
    expect(page).to_not have_content("Users")
    visit '/logout'
  end

  it 'admin user has access to the dashboard' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit '/dashboard'
    expect(current_path).to eq('/dashboard')
  end

  it 'non-admin user does not have access to the dashboard' do
    create_standard_and_admin_user
    visit '/'
    standard_user_login
    visit '/dashboard'
    expect(current_path).to eq('/')
  end

  it 'all users can access to projects and tickets menu ' do
    create_admin_user
    create_project_manager_user
    create_lead_developer_user
    create_developer_user
    visit '/'
    
    admin_user_login
    visit "/users/#{@ash.id}/projects"
    expect(current_path).to eq("/users/#{@ash.id}/projects")
    visit '/logout'
    
    project_manager_user_login
    visit "/users/#{@brock.id}/projects"
    expect(current_path).to eq("/users/#{@brock.id}/projects")
    visit '/logout'

    lead_developer_user_login
    visit "/users/#{@pikachu.id}/projects"
    expect(current_path).to eq("/users/#{@pikachu.id}/projects")
    visit '/logout'

    developer_user_login
    visit "/users/#{@misty.id}/projects"
    expect(current_path).to eq("/users/#{@misty.id}/projects")
    visit '/logout'
  end
end

describe 'Feature Test: Index, add and edit user', :type => :feature do
  it 'user index view displays all users and leads to the creation of users' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit '/users'
    expect(page).to have_content("Ash")
    expect(page).to have_content("Ketchup")
    expect(page).to have_content("Admin")
    expect(page).to have_content("ash@ketchup.com")
    expect(page).to have_content("Misty")
    expect(page).to have_content("Williams")
    expect(page).to have_content("Developer")
    expect(page).to have_content("misty@williams.com")
    expect(page).to have_content("Edit")
    expect(page).to have_content("Add new user")
    click_on("Add new user")
    expect(current_path).to eq("/users/new")
  end
  
  it 'admin user can add new users' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit '/users/new'
    expect(current_path).to eq("/users/new")
    fill_in("user_first_name", :with => "Brock")
    fill_in("user_last_name", :with => "Harrison")
    select("Developer", from: "user[role_id]")
    fill_in("user_email", :with => "brock@harrison.com")
    fill_in("user_password", :with => "password")
    fill_in("user_password_confirmation", :with => "password")
    click_button('Create User')
    
    expect(User.last.email).to eq("brock@harrison.com")
    expect(page).to have_content("Brock Harrison has been successfully created as a Developer and email brock@harrison.com.")
  end

  it 'non-admin users cannot add new users' do
    create_standard_and_admin_user
    visit '/'
    standard_user_login
    visit '/users/new'
    expect(current_path).to eq("/users/#{@misty.id}")
  end

  it 'admin user can edit users' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    visit "/users/#{@misty.id}/edit"
    expect(current_path).to eq("/users/#{@misty.id}/edit")
    fill_in("user_first_name", :with => "Brock")
    fill_in("user_last_name", :with => "Harrison")
    select("Developer", from: "user[role_id]")
    fill_in("user_email", :with => "brock@harrison.com")
    fill_in("user_password", :with => "password")
    fill_in("user_password_confirmation", :with => "password")
    click_button('Update User')
    
    expect(User.last.email).to eq("brock@harrison.com")
    expect(page).to have_content("Brock Harrison has been successfully updated as a Developer and email brock@harrison.com.")
  end

  it 'non-admin users cannot edit users' do
    create_standard_and_admin_user
    visit '/'
    standard_user_login
    visit "/users/#{@ash.id}/edit"
    expect(current_path).to eq("/users/#{@misty.id}")
  end
end