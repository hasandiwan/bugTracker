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
harold = User.create(first_name: "Harold", last_name: "Torres", role: admin, email: "harold@example.com")
siri = User.create(first_name: "Siri", last_name: "Watasir", role: project_manager, email: "siri@example.com")
grandma = User.create(first_name: "Grandma", last_name: "Boss", role: project_manager, email: "nana@example.com")
tan = User.create(first_name: "Tan", last_name: "Watasir", role: lead_developer, email: "tan@example.com")
hernando = User.create(first_name: "Hernando", last_name: "Torres", role: lead_developer, email: "hernando@example.com")
laurie = User.create(first_name: "Laurie", last_name: "Marshall", role: lead_developer, email: "laurie@example.com")
belkis = User.create(first_name: "Belkis", last_name: "Galvan", role: developer, email: "bk@example.com")
sindy = User.create(first_name: "Sindy", last_name: "Galvan", role: developer, email: "sd@example.com")
wendy = User.create(first_name: "Wendy", last_name: "Galvan", role: developer, email: "wd@example.com")
angie = User.create(first_name: "Angie", last_name: "Torres", role: developer, email: "angie@example.com")
miguel = User.create(first_name: "Miguel", last_name: "Alzate", role: developer, email: "migue@example.com")
carlos = User.create(first_name: "Carlos", last_name: "Martinez", role: developer, email: "carlos@example.com")
melissa = User.create(first_name: "Melissa", last_name: "De la Cruz", role: developer, email: "mel@example.com")
luismi = User.create(first_name: "Luis", last_name: "De la Cruz", role: developer, email: "luismi@example.com")
carmen = User.create(first_name: "Carmen", last_name: "Marino", role: developer, email: "carmen@example.com")

#Projects
logistic_software = Project.create(title: "Logistics Program", description: "Blah blah blah blah blah.", project_manager: siri, lead_developer:tan)
sales_software = Project.create(title: "Sales Program", description: "Hahahahahahah.", project_manager: siri, lead_developer:hernando)
planning_software = Project.create(title: "Planning Program", description: "hehehehehehe.", project_manager: siri, lead_developer:laurie)
improve_team_performance = Project.create(title: "Improve team performance", description: "hiihihihihihih.", project_manager: grandma, lead_developer:tan)
improve_legacy_code = Project.create(title: "Improve Legacy Code", description: "hohohohohohohoh.", project_manager: siri, lead_developer:hernando)

#Tickets

issue1= Ticket.create(title: "issue1", lead_developer: tan, project: logistic_software)
issue2= Ticket.create(title: "issue2", lead_developer: tan, project: logistic_software)
issue3= Ticket.create(title: "issue3", lead_developer: tan, project: improve_team_performance)
issue4= Ticket.create(title: "issue4", lead_developer: hernando, project: sales_software)
issue5= Ticket.create(title: "issue5", lead_developer: hernando, project: improve_legacy_code)
issue6= Ticket.create(title: "issue6", lead_developer: laurie, project: planning_software)
issue7= Ticket.create(title: "issue7", lead_developer: laurie, project: planning_software)
issue8= Ticket.create(title: "issue8", lead_developer: laurie, project: planning_software)

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



#Project Assignments
# siri_1_to_tan = ProjectAssignment.create(project: siri.projects.all[0], lead_developer: tan)
# siri_2_to_hernando = ProjectAssignment.create(project: siri.projects.all[1], lead_developer: hernando)
# siri_3_to_laurie = ProjectAssignment.create(project: siri.projects.all[2], lead_developer: laurie)
# grandma_4_to_tan = ProjectAssignment.create(project: grandma.projects.all[3], lead_developer: tan)
# siri_5_to_hernando = ProjectAssignment.create(project: siri.projects.all[4], lead_developer: hernando)
