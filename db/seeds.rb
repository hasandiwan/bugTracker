# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Roles
admin = Role.create(name: "Admin")
project_manager = Role.create(name: "Project Manager")
lead_developer = Role.create(name: "Lead Developer")
developer = Role.create(name: "Developer")

#Users
harold = User.create(first_name: "Harold", last_name: "Torres", role: admin, email: "harold@example.com", password: "password", password_confirmation: "password")
siri = User.create(first_name: "Siri", last_name: "Watasir", role: project_manager, email: "siri@example.com", password: "password", password_confirmation: "password")
grandma = User.create(first_name: "Grandma", last_name: "Boss", role: project_manager, email: "nana@example.com", password: "password", password_confirmation: "password")
tan = User.create(first_name: "Tan", last_name: "Watasir", role: lead_developer, email: "tan@example.com", password: "password", password_confirmation: "password")
hernando = User.create(first_name: "Hernando", last_name: "Torres", role: lead_developer, email: "hernando@example.com", password: "password", password_confirmation: "password")
laurie = User.create(first_name: "Laurie", last_name: "Marshall", role: lead_developer, email: "laurie@example.com", password: "password", password_confirmation: "password")
belkis = User.create(first_name: "Belkis", last_name: "Galvan", role: developer, email: "bk@example.com", password: "password", password_confirmation: "password")
sindy = User.create(first_name: "Sindy", last_name: "Galvan", role: developer, email: "sd@example.com", password: "password", password_confirmation: "password")
wendy = User.create(first_name: "Wendy", last_name: "Galvan", role: developer, email: "wd@example.com", password: "password", password_confirmation: "password")
angie = User.create(first_name: "Angie", last_name: "Torres", role: developer, email: "angie@example.com", password: "password", password_confirmation: "password")
miguel = User.create(first_name: "Miguel", last_name: "Alzate", role: developer, email: "migue@example.com", password: "password", password_confirmation: "password")
carlos = User.create(first_name: "Carlos", last_name: "Martinez", role: developer, email: "carlos@example.com", password: "password", password_confirmation: "password")
melissa = User.create(first_name: "Melissa", last_name: "De la Cruz", role: developer, email: "mel@example.com", password: "password", password_confirmation: "password")
luismi = User.create(first_name: "Luis", last_name: "De la Cruz", role: developer, email: "luismi@example.com", password: "password", password_confirmation: "password")
carmen = User.create(first_name: "Carmen", last_name: "Marino", role: developer, email: "carmen@example.com", password: "password", password_confirmation: "password")

#Projects
logistic_software = Project.create(title: "Logistics Program", description: "Blah blah blah blah blah.", project_manager: siri, lead_developer:tan)
sales_software = Project.create(title: "Sales Program", description: "Hahahahahahah.", project_manager: siri, lead_developer:hernando)
planning_software = Project.create(title: "Planning Program", description: "hehehehehehe.", project_manager: siri, lead_developer:laurie)
improve_team_performance = Project.create(title: "Improve team performance", description: "hiihihihihihih.", project_manager: grandma, lead_developer:tan)
improve_legacy_code = Project.create(title: "Improve Legacy Code", description: "hohohohohohohoh.", project_manager: siri, lead_developer:hernando)

#Tickets

issue1= Ticket.create(title: "issue number 1", description: "hahahaha", lead_developer: tan, project: logistic_software, status: "Open", priority: "Critical", category: "Bug")
issue2= Ticket.create(title: "issue number 2", description: "hehehehe", lead_developer: tan, project: logistic_software, status: "In progress", priority: "Low", category: "Enhancement")
issue3= Ticket.create(title: "issue number 3", description: "hihihihi", lead_developer: tan, project: improve_team_performance, status: "Open", priority: "High", category: "Bug")
issue4= Ticket.create(title: "issue number 4", description: "hohohoho", lead_developer: hernando, project: sales_software, status: "Closed", priority: "Medium", category: "Training")
issue5= Ticket.create(title: "issue number 5", description: "huhuhuhu", lead_developer: hernando, project: improve_legacy_code , status: "In progress", priority: "High", category: "Bug")
issue6= Ticket.create(title: "issue number 6", description: "lalalala", lead_developer: laurie, project: planning_software, status: "In progress", priority: "Medium", category: "Potential Bug")
issue7= Ticket.create(title: "issue number 7", description: "blahblahblah", lead_developer: laurie, project: planning_software, status: "Closed", priority: "High", category: "Bug")
issue8= Ticket.create(title: "issue number 8", description: "mmmmmmmmm", lead_developer: laurie, project: planning_software, status: "In progress", priority: "Low", category: "Bug")

#Ticket Assignments

ticket_assignment1= TicketAssignment.create(ticket: issue1, developer:belkis)
ticket_assignment2=TicketAssignment.create(ticket: issue1, developer:sindy)
ticket_assignment3=TicketAssignment.create(ticket: issue1, developer:wendy)
ticket_assignment4=TicketAssignment.create(ticket: issue2, developer:angie)
ticket_assignment5=TicketAssignment.create(ticket: issue2, developer:miguel)
ticket_assignment6=TicketAssignment.create(ticket: issue3, developer:miguel)
ticket_assignment7=TicketAssignment.create(ticket: issue4, developer:miguel)
ticket_assignment8=TicketAssignment.create(ticket: issue5, developer:carlos)
ticket_assignment9=TicketAssignment.create(ticket: issue5, developer:melissa)
ticket_assignment10=TicketAssignment.create(ticket: issue6, developer:belkis)
ticket_assignment11=TicketAssignment.create(ticket: issue7, developer:luismi)
ticket_assignment12=TicketAssignment.create(ticket: issue8, developer:luismi)
ticket_assignment13=TicketAssignment.create(ticket: issue8, developer:carmen)

#Comments

comment_1 = Comment.create(ticket: issue1, user:harold, message:"hello")
comment_2 = Comment.create(ticket: issue1, user:belkis, message:"hallo")
comment_3 = Comment.create(ticket: issue1, user:sindy, message:"hola")
comment_4 = Comment.create(ticket: issue2, user:harold, message:"kumusta")
comment_5 = Comment.create(ticket: issue4, user:miguel, message:"thank you")
comment_6 = Comment.create(ticket: issue8, user:carmen, message:"sparsiva")
comment_7 = Comment.create(ticket: issue8, user:laurie, message:"danke")

