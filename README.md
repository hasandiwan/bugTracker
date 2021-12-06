# README

Welcome to my Bug Tracker application. If you're interested in a detailed explanation of what this app consists of, please read the following article:

https://medium.com/nerd-for-tech/bug-tracker-my-ruby-on-rails-application-project-501318983d37

To get the application up and running, please make do the following:

1. Install **Postgresql** as this is the database this app is configured to use. If you already have it, please go to step 2. 

In order to install Postgresql, you will need **Homebrew** prevously installed. If you do not have it, please run:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

```
And then run the following to install **Postgresql**:

```
brew install postgresql
```

2. To get the application up and running, please make sure you are using Ruby 2.7.4, otherwise go to the Gemfile and change it to the version you currently have. Then please run:

```
bundle install
```
3. This app uses Active Storage. Please run the following to install it:
```
bin/rails active_storage:install
```

4. To migrate and seed the database with mock data, please run:

```
rake db:create db:migrate db:seed
```

5. To call the server run:

```
thin start --ssl
```

5. Finally, go to https://localhost:3000. Make sure it includes the **https** protocol