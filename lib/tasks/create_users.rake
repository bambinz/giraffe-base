desc "Create users"
task :create_users => :environment do
  100.times do
    u = User.new
    u.username = Faker::Name.name
    u.password = "foobar"
    u.password_confirmation = "foobar"
    u.email = Faker::Internet.email
    u.roles << Role.find_by_name(:user)
    u.save
  end
  puts "Done."
end