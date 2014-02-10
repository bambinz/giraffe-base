desc "Create admin user"
task :create_admin => :environment do
  u = User.new
  u.username = "admin"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.email = "admin@test.com"
  r = Role.find_by_name(:admin)
  if !r
    puts "Run the roles rake task first..."
  else
    u.roles << r
    s = u.build_setting
    s.show_in_search = true
    s.accept_friend_reqests = true
    s.public_profile = true
    s.save
    ret = u.save
    puts ret
  end
end