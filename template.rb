#################################################
# Helpers
#################################################

#
def get_active_ruby(patch = false)
  !patch || (RUBY_PATCHLEVEL == 0) ? "#{RUBY_VERSION}" : "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
end




#################################################
# Ruby Version
#################################################

# Use active Ruby
run "rbenv local #{get_active_ruby(true)}"



#################################################
# Configure Gems
#################################################

# Application
#gem 'figaro'

# Layout
#gem 'slim-rails'
#gem 'sass-rails'
#gem 'bootstrap-sass'
#gem 'font-awesome-rails'

# JS
#gem 'coffee-rails'
#gem 'jbuilder'
#gem 'jquery-rails'
#gem 'nprogress-rails'
#gem 'turbolinks'
#gem 'uglifier'

#
#gem_group :development do
#  # Application Server
#  gem 'thin'
#
#  # Console, Debug and Logging
#  gem 'pry-rails'
#  gem 'binding_of_caller'
#  gem 'better_errors'
#  gem 'quiet_assets'
#end

#
#gem_group :development, :test do
#  gem 'minitest-rails'
#end
#
#gem_group :test do
#  gem 'turn'
#end



#################################################
# Gemfile
#################################################

# Gemfile
run 'mv Gemfile Gemfile.orig'
file 'Gemfile', <<-END
source 'https://rubygems.org'

# Ruby
ruby '#{get_active_ruby}'

# Ruby on Rails
gem 'rails', '4.0.2'

# DB
gem 'pg'

# Application
gem 'figaro'

# Layout
gem 'slim-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'

# JS
gem 'coffee-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'nprogress-rails'
gem 'turbolinks'
gem 'uglifier'

#
group :development do
  # Application Server
  gem 'thin'

  # Console, Debug and Logging
  gem 'pry-rails'
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'quiet_assets'
end

#
group :development, :test do
  gem 'minitest-rails'
end

#
group :test do
  gem 'turn'
end
END

# Bundle Installation
run 'bundle install'


#################################################
# Figaro
#################################################

# application.yml
file 'config/application.yml', <<-END
HOST: 'localhost:3000'
DEFAULT_EMAIL: 'mail@example.com'

development:
  HOST: 'localhost:3000'
  DEFAULT_EMAIL: 'mail@example.com'

production:
  HOST: 'localhost:3000'
  DEFAULT_EMAIL: 'mail@example.com'
END



#################################################
# MiniTest | Turn
#################################################

# test_helper.rb
file 'test/test_helper.rb', <<-END
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/rails'

Turn.config.format = :dot

class ActiveSupport::TestCase
  fixtures :all
end

module Minitest::Expectations
end
END

# Use spec format for minitest and don't generate assets and helpers
environment <<-END
# Use spec format for minitest and don't generate assets and helpers
    config.generators do |g|
      g.test_framework :mini_test, spec: true, fixture: false
      g.assets         false
      g.helper         false
    end
END



#################################################
# Slim
#################################################

# application.html.slim
remove_file 'app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.slim', <<-END
doctype html
html
  head
    title #{app_const_base}

    meta charset='utf-8'
    meta content='IE=edge,chrome=1' http-equiv='X-UA-Compatible'
    meta name='viewport' content='width=device-width, initial-scale=1.0'

    / CSS
    = stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true

    / JS
    = javascript_include_tag 'application', 'data-turbolinks-track' => true

    / CSRF
    = csrf_meta_tags

    / Favicon
    = favicon_link_tag 'favicon.png'

  body
    = yield
END

# Pretty HTML indenting on development
environment '# Pretty HTML indenting on development
  Slim::Engine.set_default_options pretty: true', env: 'development'



#################################################
# Assets :: CSS
#################################################

# application.css
remove_file 'app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.css', <<-END
/*
 *= require_self
 *= require style
 */
END

# style.css.scss
file 'app/assets/stylesheets/style.css.scss', <<-END
@charset "utf-8";

/*
    Imports
*/
@import 'bootstrap-custom';
@import 'font-awesome';
@import 'nprogress-custom';
END

# _bootstrap-custom.css.scss
file 'app/assets/stylesheets/_bootstrap-custom.css.scss'

#_nprogress-custom.css.scss
file 'app/assets/stylesheets/_nprogress-custom.css.scss', <<-END
$nprogress-color: #3b5998;

@import 'nprogress';
@import 'nprogress-bootstrap';

#nprogress .peg{
  box-shadow: 0 0 0 transparent;
}
END



#################################################
# Assets :: JS
#################################################

# application.js
remove_file 'app/assets/javascripts/application.js'
file 'app/assets/javascripts/application.js', <<-END
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require bootstrap
//= require main
END

# main.js
file 'app/assets/javascripts/main.js', <<-END
var Application = {};

/*
    Fetch Page
*/
Application.fetchPage = function ()
{
  console.log('[Turbolinks] Fetching page...');
  NProgress.start();
};

/*
    Change Page
*/
Application.changePage = function ()
{
  console.log('[Turbolinks] Page changed!');
  NProgress.done();
};

/*
    Restore Page
*/
Application.restorePage = function ()
{
  console.log('[Turbolinks] Page restored!');
  NProgress.remove();
};

/*
    Application :: Initialize
*/
Application.initialize = function ()
{
  console.log('[Application::initialize] Intializing Application');
};


/*
    NProgress
*/
NProgress.configure(
  {
    showSpinner: false
  }
);


/*
    DOM Ready
*/
$(document).ready(
  function ()
  {
    Application.initialize();
  }
);


/*
    Turbolinks
*/
$(document)
  .on('page:load', Application.initialize)
  .on('page:fetch', Application.fetchPage)
  .on('page:change', Application.changePage)
  .on('page:restore', Application.restorePage);
END



#################################################
# Controllers
#################################################

# welcome
generate :controller, 'welcome index'



#################################################
# Routes
#################################################

# root
route "root to: 'welcome#index'"



#################################################
# README
#################################################

# README.md
remove_file 'README.rdoc'
file 'README.md', <<-END
# #{app_const_base}

## Installation

#### Development
```sh
bundle install
cp config/database.example.yml config/database.yml
cp config/application.example.yml config/application.yml
rake db:setup
```
END



#################################################
# Bundle
#################################################

run 'bundle install'



#################################################
# Git
#################################################

# .gitignore
run 'cp config/database.yml config/database.example.yml'
run 'cp config/application.yml config/application.example.yml'
run "echo '
# Ignore application specific files.
Gemfile.orig
config/database.yml
config/application.yml' >> .gitignore"

# git init
git :init
git add: '.'