# Rails Basic Template

A Ruby on Rails 4 template.

> *This project was based on [rails_basic_template](https://github.com/apod/rails_basic_template) by [apod](https://github.com/apod).*

## Features

1. Local Ruby version setup with [rbenv](https://github.com/sstephenson/rbenv).
2. Use [PostgreSQL](http://www.postgresql.org/) for Active Record database.
3. [Slim Engine](http://slim-lang.com/) for views layout.
4. [Bootstrap](http://getbootstrap.com/) as front-end framework.
5. [Font Awesome](http://fontawesome.io/) for iconic font.
6. Utilize [Turbolinks](https://github.com/rails/turbolinks) and style progress with [NProgress.js](http://ricostacruz.com/)

## Gem List

##### Database
 - [pg](https://bitbucket.org/ged/ruby-pg)

##### Application Server
 - [thin](https://github.com/macournoyer/thin) for Development
 
##### Application Configuration
 - [Figaro](https://github.com/laserlemon/figaro)

##### Layout
 - [slim-rails](https://github.com/slim-template/slim-rails)
 - [sass-rails](https://github.com/rails/sass-rails)
 - [bootstrap-sass](http://github.com/thomas-mcdonald/bootstrap-sass)
 - [font-awesome-rails](https://github.com/bokmann/font-awesome-rails)

##### Javascript
 - [coffee-rails](https://github.com/rails/coffee-rails)
 - [jbuilder](https://github.com/rails/jbuilder)
 - [jquery-rails](http://rubygems.org/gems/jquery-rails)
 - [nprogress-rails](https://github.com/caarlos0/nprogress-rails)
 - [turbolinks](https://github.com/rails/turbolinks/)
 - [uglifier](http://github.com/lautis/uglifier)

##### Console, Debug & Log
 - [pry-rails](https://github.com/rweng/pry-rails)
 - [binding_of_caller](http://github.com/banister/binding_of_caller)
 - [better_errors](https://github.com/charliesome/better_errors)
 - [quiet_assets](https://github.com/evrone/quiet_assets)

##### Test
 - [minitest-rails](https://github.com/blowmage/minitest-rails)
 - [turn](https://github.com/turn-project/turn)
    
## Script Process

1. Set local Ruby version with [rbenv](https://github.com/sstephenson/rbenv).
    ```rbenv local 'active_ruby_version'```

2. Monkey business: Move original `Gemfile` to `Gemfile.orig`, write a new one with the desired layout and run `bundle install`.

3. Application configuration with [figaro](https://github.com/laserlemon/figaro).

4. Configure [minitest-rails](https://github.com/blowmage/minitest-rails).

5. Use [turn](https://github.com/turn-project/turn)'s dot format for test results.

6. Configure `Generators` to use `spec` format for `minitest` and skip *assets* and *helpers* creation.

7. Configure [Slim](http://slim-lang.com/) and set pretty html output for development.
    ```Slim::Engine.set_default_options pretty: true```

8. Configure *stylesheet* and *javascript* assets.

9. Create a *Welcome* controller with index action and set it as root route.
    ```root to: 'welcome#index'```

10. Move `README.rdoc` to `README.md`.

11. Create `database.example.yml` and `application.example.yml` based on the default files.

12. Add `Gemfile.orig`, `database.yml`, `application.yml` to `.gitignore`.

13. Initialize `git`.

## How To Use

```sh
rails new my_app -d postgresql -T -m https://raw.github.com/cvkef/basic_rails_template/master/template.rb
```

## Post Installation Actions

Edit `database.yml` with your `pg` settings and run in console:
```sh
bundle exec rake db:setup 
bundle exec rake db:migrate
```


----------
*README edited with [StackEdit](https://stackedit.io)*.