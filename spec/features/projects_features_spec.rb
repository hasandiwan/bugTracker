require_relative "../rails_helper.rb"

describe 'Feature Test: Project Index, Add and Edit', :type => :feature do
  it 'admin user can see Project Managers and Lead Developers info' do
    create_standard_and_admin_user
    visit '/'
    admin_user_login
    click_link("Projects")
    expect(page).to have_content("Project Manager")
    expect(page).to have_content("Lead Developer")
  end

  it 'admin user can add and edit a project' do
    create_standard_and_admin_user
    create_project_manager_user
    create_lead_developer_user
    visit '/'
    admin_user_login
    visit "/users/#{@ash.id}/projects/new"
    expect(current_path).to eq("/users/#{@ash.id}/projects/new")
    
    fill_in("project_title", :with => "Brock's project")
    fill_in("project_description", :with => "Blah")
    select("brock@harrison.com", from: "project[project_manager_id]")
    select("pika@chu.com", from: "project[lead_developer_id]")
    click_button('Create Project')
    expect(Project.last.title).to eq("Brock's project")

    visit "/projects/#{Project.last.id}/edit"
    expect(current_path).to eq("/projects/#{Project.last.id}/edit")

    fill_in("project_title", :with => "Brock's project edited")
    fill_in("project_description", :with => "Blah")
    select("brock2@harrison.com", from: "project[project_manager_id]")
    select("pika@chu.com", from: "project[lead_developer_id]")
    click_button('Update Project')

    expect(Project.last.title).to eq("Brock's project edited")
  end

  it 'project manager user can add and edit a project' do
    create_project_manager_user
    create_lead_developer_user
    visit '/'
    project_manager_user_login
    visit "/users/#{@brock.id}/projects/new"
    expect(current_path).to eq("/users/#{@brock.id}/projects/new")
    
    fill_in("project_title", :with => "Brock's project")
    fill_in("project_description", :with => "Blah")
    select("pika@chu.com", from: "project[lead_developer_id]")
    click_button('Create Project')
    expect(Project.last.title).to eq("Brock's project")

    visit "/projects/#{Project.last.id}/edit"
    expect(current_path).to eq("/projects/#{Project.last.id}/edit")

    fill_in("project_title", :with => "Brock's project edited")
    fill_in("project_description", :with => "Blah")
    select("pika@chu.com", from: "project[lead_developer_id]")
    click_button('Update Project')

    expect(Project.last.title).to eq("Brock's project edited")
  end

  it 'project manager user cannot add or edit projects to other project managers' do
    create_project_manager_user
    create_lead_developer_user
    visit '/'
    project_manager_user_login
    visit "/users/#{@brock.id}/projects/new"
    fill_in("project_title", :with => "Brock's project")
    fill_in("project_description", :with => "Blah")
    first('input#project_project_manager_id', visible: false).set(@brock2.id)
    select("pika@chu.com", from: "project[lead_developer_id]")
    click_button('Create Project')
    expect(page).to have_content("Logged user id doesn't match the id of the user submitting the form, please try again.")

    click_button('Create Project')
    visit "/projects/#{Project.last.id}/edit"
    first('input#project_project_manager_id', visible: false).set(@brock2.id)
    click_button('Update Project')
    expect(page).to have_content("Logged user id doesn't match the id of the user submitting the form, please try again.")
  end

  it 'lead developer user cannot add new projects' do
    create_project_manager_user
    create_lead_developer_user
    visit '/'
    lead_developer_user_login
    visit "/users/#{@pikachu.id}/projects/new"
    expect(current_path).to eq("/users/#{@pikachu.id}")
  end

  it 'developer user cannot add new projects' do
    create_project_manager_user
    create_lead_developer_user
    create_developer_user
    visit '/'
    developer_user_login
    visit "/users/#{@misty.id}/projects/new"
    expect(current_path).to eq("/users/#{@misty.id}")
  end

end

describe 'Feature Test: Project Show', :type => :feature do
  
end