# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


harold = User.create(name: "Harold")
siri = User.create(name: "Siri")
tan =User.create(name: "Tan")
hernando =User.create(name: "Hernando")

harold_to_siri = Message.create(sender: harold, recipient: siri, content: "Hi Siri")
hernando_to_harold = Message.create(sender: hernando, recipient: harold, content: "Hi Harold")
tan_to_hernando = Message.create(sender: tan, recipient: hernando, content: "Hi Hernando")
harold_to_tan =  Message.create(sender: harold, recipient: tan, content: "Hi Tan")