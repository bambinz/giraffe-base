desc "Create user roles"
task :create_roles => :environment do
  create_role "admin"
  create_role "user"
end

def create_role(name)
  role = Role.find_by_name(name)
  if !role
    role = Role.new
    role.name = name
    role.save
  end
  
  puts "Created role: #{name}"
end


