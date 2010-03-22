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

# if added in one line as git :add => "", :commit => ""
# commit is executed first for whatever reason
git :add => "."
git :commit => "-m 'initial commit'"
