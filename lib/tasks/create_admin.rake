desc "Create admin user"
task :create_admin => :environment do
  u = User.new
  u.username = "admin"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.email = "admin@test.com"
  u.roles << Role.find_by_name(:admin)
  ret = u.save
  puts ret
end