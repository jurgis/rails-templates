# Delete unnecessary files
run "rm README"
run "rm public/index.html"
run "rm public/images/rails.png"
run "rm -f public/javascripts/*"


# Initialize git
git :init
# Initialize submodules
git :submodule => "init"


# Add gems

# Only one of them will be used
gem 'postgres'
gem 'sqlite3-ruby', :lib => 'sqlite3'

gem 'mislav-will_paginate', :lib => 'will-paginate', :source => 'http://gems.github.com'
gem 'authlogic'
gem 'authlogic-oid', :lib => 'authlogic_openid'
gem 'ruby-openid', :lib => 'openid'
gem 'ambethia-smtp-tls', :lib => 'smtp-tls', :source => 'http://gems.github.com'

# gems in test env
gem 'rspec', :lib => false, :version => '>=1.2.6', :environment => :test
gem 'rspec-rails', :lib => false, :version => '>=1.2.6', :environment => :test
gem 'webrat', :lib => false, :version => '>=0.4.4', :environment => :test
gem 'cucumber', :lib => false, :version => '>=0.3.2', :environment => :test
gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => 'http://gems.github.com', :environment => :test

rake 'gems:install', :sudo => true
rake 'gems:install', :environment => :test, :sudo => true 


# Add plugins
plugin 'open_id_authentication', :git => 'git://github.com/rails/open_id_authentication.git'

#TODO: NOT WORKING YET!!!
# rake 'open_id_authentication:db:create'


#TODO: NOT WORKING YET!!!
# Run required generators
# generate 'rspec', :environment => :test
# generate 'cucumber', :environment => :test


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
