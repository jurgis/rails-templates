git :init
 
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/database_example.yml"
 
file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
vendor/rails
END
 
git :add => ".", :commit => "-m 'initial commit'"
