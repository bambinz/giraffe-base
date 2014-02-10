desc "Create users"
task :create_users => :environment do
  400.times do
    u = User.new
    u.username = Faker::Name.name
    u.password = "foobar"
    u.password_confirmation = "foobar"
    u.email = Faker::Internet.email
    r = Role.find_by_name(:user)
    if !r
      puts "Run the roles rake task first..."
      return nil
    else
      u.roles << r
      s = u.build_setting
      s.show_in_search = true
      s.accept_friend_reqests = true
      s.public_profile = true
      s.save
      u.save
    end
  end
  puts "Done."
end