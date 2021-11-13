module LoginHelper

  # def user_signup
  #   fill_in("user[first_name]", :with => "Amy Poehler")
  #   fill_in("user[lat_name]", :with => "58")
  #   select("Admin", :from => "role")
  #   fill_in("user[email]", :with => "2")
  #   fill_in("user[password]", :with => "password")
  #   click_button('Create User')
  # end

  def admin_user_login
    fill_in("email", :with => "ash@ketchup.com")
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  def standard_user_login
    fill_in("email", :with => "misty@williams.com")
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  # def admin_signup
  #   fill_in("user[name]", :with => "Walt Disney")
  #   fill_in("user[password]", :with => "password")
  #   find(:css, "#user_admin").set(true)
  #   click_button('Create User')
  # end

  # def admin_login
  #   select 'Walt Disney',from:'user_name'
  #   fill_in("password", :with => "password")
  #   click_button('Sign In')
  # end

  def create_admin_user 
    @admin_role = Role.create(name:"Admin")

    @ash = User.create(
      first_name: "Ash",
      last_name: "Ketchup",
      role: @admin_role,
      email: "ash@ketchup.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  def create_standard_and_admin_user 
    @admin_role = Role.create(name:"Admin")
    @standard_role = Role.create(name:"Developer")
    @ash = User.create(
      first_name: "Ash",
      last_name: "Ketchup",
      role: @admin_role,
      email: "ash@ketchup.com",
      password: "password",
      password_confirmation: "password"
    )
    @misty = User.create(
      first_name: "Misty",
      last_name: "Williams",
      role: @standard_role,
      email: "misty@williams.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  # def create_standard_and_admin_user
  #   @mindy = User.create(
  #     name: "Mindy",
  #     password: "password",
  #     happiness: 3,
  #     nausea: 2,
  #     tickets: 10,
  #     height: 50
  #   )
  #   @walt = User.create(
  #     name: "Walt Disney",
  #     password: "password",
  #     admin: true
  #   )
  # end
  
end