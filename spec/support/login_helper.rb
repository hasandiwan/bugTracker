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
    developer_user_login
  end

  def project_manager_user_login
    fill_in("email", :with => "brock@harrison.com")
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  def lead_developer_user_login
    fill_in("email", :with => "pika@chu.com")
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

  def developer_user_login
    fill_in("email", :with => "misty@williams.com")
    fill_in("password", :with => "password")
    click_button('Sign In')
  end

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
  
  def create_project_manager_user 
    @project_manager_role = Role.create(name:"Project Manager")
    @brock = User.create(
      first_name: "Brock",
      last_name: "Harrison",
      role: @project_manager_role,
      email: "brock@harrison.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  def create_lead_developer_user 
    @lead_developer_role = Role.create(name:"Lead Developer")
    @pikachu = User.create(
      first_name: "Pika",
      last_name: "Chu",
      role: @lead_developer_role,
      email: "pika@chu.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  def create_developer_user 
    @developer_role = Role.create(name:"Developer")
    @misty = User.create(
      first_name: "Misty",
      last_name: "Williams",
      role: @developer_role,
      email: "misty@williams.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  
end