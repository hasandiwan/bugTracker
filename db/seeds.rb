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
developer = Role.create(name: "Developer")

#Users
harold = User.create(first_name: "Harold", last_name: "Torres", role: admin, email: "harold@example.com")
siri = User.create(first_name: "Siri", last_name: "Watasir", role: project_manager, email: "siri@example.com")
grandma = User.create(first_name: "Grandma", last_name: "Boss", role: project_manager, email: "nana@example.com")
tan = User.create(first_name: "Tan", last_name: "Watasir", role: developer, email: "tan@example.com")
hernando = User.create(first_name: "Hernando", last_name: "Torres", role: developer, email: "hernando@example.com")
laurie = User.create(first_name: "Laurie", last_name: "Marshal", role: developer, email: "laurie@example.com")

#Projects
logistic_software = Project.create(title: "Logistics Program", description: "Blah blah blah blah blah.", project_manager: siri)
sales_software = Project.create(title: "Sales Program", description: "Hahahahahahah.", project_manager: grandma)

#Project Assignments
siri_1_to_tan = ProjectAssignment.create(project: siri.projects.first, developer: tan)
siri_1_to_hernando = ProjectAssignment.create(project: siri.projects.first, developer: hernando)
siri_1_to_laurie = ProjectAssignment.create(project: siri.projects.first, developer: laurie)
grandma_1_to_tan = ProjectAssignment.create(project: grandma.projects.first, developer: tan)
siri_2_to_laurie = ProjectAssignment.create(project: siri.projects.second, developer: laurie)
