# Delete unnecessary files
run "rm README"
run "rm public/index.html"
run "rm public/images/rails.png"
run "rm -f public/javascripts/*"

# download additional files
# run "curl -L http://code.jquery.com/jquery-1.4.2.min.js > public/javascripts/jquery.js"


# Initialize git
git :init
# Initialize submodules
git :submodule => "init"


# Adding gems (gems are added in reverse order in the environment.rb file !!!)
gem 'nifty-generators', :version => ">=0.3.2", :lib => false, :source => 'http://gemcutter.org'
gem 'web-app-theme', :lib => false, :source => 'http://gemcutter.org'
gem 'will_paginate', :version => '~>2.3.11', :source => 'http://gemcutter.org'
gem 'ambethia-smtp-tls', :lib => 'smtp-tls', :source => 'http://gems.github.com'
gem 'rack-openid', :version => '>=0.2.1', :lib => 'rack/openid' # hack for open_id_authentication plugin not to break it
gem 'authlogic-oid', :lib => 'authlogic_openid'
gem 'authlogic'
gem 'ruby-openid', :lib => 'openid'
# Only one of them will be used
gem 'postgres'
gem 'sqlite3-ruby', :lib => 'sqlite3'

# gems in test env (are added in correct order)
gem 'rspec', :lib => false, :version => '>=1.3.0', :env => :test
gem 'rspec-rails', :lib => false, :version => '>=1.3.2', :env => :test
gem 'webrat', :lib => false, :version => '>=0.7.0', :env => :test
# required by cucumber (should be defined as depenency in cucumber or cucumber-rails)
gem 'database_cleaner', :lib => false, :version => ">= 0.5.0", :env => :test
gem 'cucumber', :lib => false, :version => '>=0.6.3', :env => :test
gem 'cucumber-rails', :lib => false, :version => '>=0.3.0', :env => :test
gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :version => '>=1.2.2',  :source => 'http://gems.github.com', :env => :test

rake 'gems:install', :sudo => true
rake 'gems:install', :env => :test, :sudo => true 


# Add plugins as git submodules
plugin 'open_id_authentication', :git => 'git://github.com/rails/open_id_authentication.git', :submodule => true

# does not exist any more
# rake 'open_id_authentication:db:create'


# Run required generators
generate 'rspec'
generate 'cucumber', '--webrat'
generate 'theme'
# generate welcome controller which will choose a proper locale and redirect to another controller later
# and will be used right now to display application theme
generate 'rspec_controller', 'welcome index'


# Add routes
route "map.root :controller => 'welcome'"

# Run required rake tasks
rake 'db:create'
rake 'db:migrate'


# Create gitignore files and add everything to git repo
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/database_example.yml"
 
file ".gitignore", <<-END
.DS_Store
log/*.log
log/*.pid
tmp/**/*
config/database.yml
db/*.sqlite3
vendor/rails
doc/api
doc/app
END

# if added in one line as git :add => "", :commit => ""
# commit is executed first for whatever reason
git :add => "."
git :commit => "-m 'initial commit'"
