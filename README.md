# README

1. To get the application up and running, please make sure you are using Ruby 2.7.4, otherwise go to the Gemfile and change it to the version you currently have. Then please run:

```
bundle install
```
2. To migrate and seed the database with mock data, please run:

```
rake db:migrate db:seed
```

3. To call the server run:

```
rails server
```

If you want to log in with any existing the password is "password" without quotes.

Example of an admin user:

```
email: harold@example.com
password: password
```

Keep in mind you can create new users from the homepage!