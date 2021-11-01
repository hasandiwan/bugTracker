require 'rails_helper'

RSpec.describe User, type: :model do
  let(:role) {
    Role.create(name: "Role")
  }
  let(:user) {
    User.create(
      first_name: "Harold",
      last_name: "Torres",
      role: role,
      email: "harold@example.com",
      password: "abcde12345"
    )
  }
  let(:lead_developer) {
    Role.create(name: "Lead Developer")
  }

  let(:project_manager) {
    Role.create(name: "Project Manager")
  }

  let(:developer) {
    Role.create(name: "Developer")
  }

  let(:project_manager_user) {
    User.create(
      first_name: "Siri", 
      last_name: "Watasir", 
      role: project_manager, 
      email: "siri@example.com",
      password: "password"
    )
  }

  let(:lead_developer_user) {
    User.create(
      first_name: "Tan", 
      last_name: "Watasir", 
      role: lead_developer, 
      email: "tan@example.com",
      password: "password"
    )
  }

  let(:lead_developer_user_2) {
    User.create(
      first_name: "Carlos", 
      last_name: "Martinez", 
      role: lead_developer, 
      email: "carlos@example.com",
      password: "password"
    )
  }

  let(:developer_user) {
    User.create(
      first_name: "Miguel", 
      last_name: "Alzate", 
      role: developer, 
      email: "migue@example.com",
      password: "password"
    )
  }

  let(:developer_user_2) {
    User.create(
      first_name: "Hernando", 
      last_name: "Torres", 
      role: developer, 
      email: "pa@example.com",
      password: "password"
    )
  }
  
  let(:project_1) {
    Project.create(
      title: "Logistics Program", 
      description: "Blah blah blah blah blah.", 
      project_manager: project_manager_user, 
      lead_developer: lead_developer_user
    )
  }

  let(:project_2) {
    Project.create(
      title: "Sales Program", 
      description: "Blah blah blah blah blah.", 
      project_manager: project_manager_user, 
      lead_developer: lead_developer_user
    )
  }

  let(:ticket_1) {
    Ticket.create(
      title: "issue1", 
      description: "hahahahahahahahah", 
      lead_developer: lead_developer_user, 
      project: project_1, 
      priority: "Low", 
      status: "Closed", 
      category: "Bug")
  }

  let(:ticket_2) {
    Ticket.create(
      title: "issue2", 
      description: "hahahahahahahahah", 
      lead_developer: lead_developer_user, 
      project: project_1, 
      priority: "Low", 
      status: "Closed", 
      category: "Bug")
  }

  let(:ticket_assignment_1) {
    TicketAssignment.create(ticket: ticket_1, developer: developer_user)
  }

  let(:ticket_assignment_2) {
    TicketAssignment.create(ticket: ticket_2, developer: developer_user)
  }

  let(:ticket_assignment_3) {
    TicketAssignment.create(ticket: ticket_2, developer: developer_user_2)
  }

  it "is valid with a first name, last name, role, email, and password" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(
      first_name: "Name",
      last_name: "Last Name",
      role_id: 1,
      email: "email@example.com",
      )).not_to be_valid
  end

  it "has many sent_projects as a project manager" do
    expect(project_manager_user.sent_projects).to eq([project_1,project_2])
  end
  
  it "has many received_projects as a lead developer" do
    expect(lead_developer_user.received_projects).to eq([project_1,project_2])
  end

  it "has many tickets as a lead developer" do
    expect(lead_developer_user.tickets).to eq([ticket_1,ticket_2])
  end

  it "has many ticket assignments as a developer" do
    expect(developer_user.ticket_assignments).to eq([ticket_assignment_1, ticket_assignment_2])
  end

  it "has many developers as a lead developer" do
    laurie = User.create(first_name: "Laurie", last_name: "Marshall", role: lead_developer, email: "laurie@example.com", password: "password")
    belkis = User.create(first_name: "Belkis", last_name: "Galvan", role: developer, email: "bk@example.com", password: "password")
    luismi = User.create(first_name: "Luis", last_name: "De la Cruz", role: developer, email: "luismi@example.com", password: "password")
    carmen = User.create(first_name: "Carmen", last_name: "Marino", role: developer, email: "carmen@example.com", password: "password")
    planning_software = Project.create(title: "Planning Program", description: "hehehehehehe.", project_manager: project_manager_user, lead_developer:laurie)
    issue6= Ticket.create(title: "issue6", lead_developer: laurie, project: planning_software)
    issue7= Ticket.create(title: "issue7", lead_developer: laurie, project: planning_software)
    issue8= Ticket.create(title: "issue8", lead_developer: laurie, project: planning_software)
    ticket_assignment10=TicketAssignment.create(ticket: issue6, developer:belkis)
    ticket_assignment11=TicketAssignment.create(ticket: issue7, developer:luismi)
    ticket_assignment12=TicketAssignment.create(ticket: issue8, developer:luismi)
    ticket_assignment13=TicketAssignment.create(ticket: issue8, developer:carmen)
    expect(laurie.developers.count).to eq(4)
  end

  it "has many lead developers as a project manager" do
    siri = User.create(first_name: "Siri", last_name: "Watasir", role: project_manager, email: "siri@example.com", password: "password")
    logistic_software = Project.create(title: "Logistics Program", description: "Blah blah blah blah blah.", project_manager: siri, lead_developer:lead_developer_user)
    sales_software = Project.create(title: "Sales Program", description: "Hahahahahahah.", project_manager: siri, lead_developer:lead_developer_user_2)
    expect(siri.lead_developers.count).to eq(2)

  end


  # it "belongs to one project" do
  #   expect(ticket.project).to eq(project)
  # end

  # it "has many ticket_assignments and has many developers" do
  #   carmen = User.create(first_name: "Carmen", last_name: "Marino", role: developer, email: "carmen@example.com")
  #   luismi = User.create(first_name: "Luis", last_name: "De la Cruz", role: developer, email: "luismi@example.com")
  #   ticket_assignment1 = TicketAssignment.create(ticket: ticket, developer: carmen)
  #   ticket_assignment2 = TicketAssignment.create(ticket: ticket, developer: luismi)
  #   expect(ticket.ticket_assignments).to eq([ticket_assignment1,ticket_assignment2])
  #   expect(ticket.developers).to eq([carmen,luismi])
  # end

end