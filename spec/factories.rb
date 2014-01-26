FactoryGirl.define do
  factory :admin, class: User do
    username "admin"
    password  "foobar"
    password_confirmation "foobar"
    email "admin@example.com"

    after(:create) do |user|
      user.roles << FactoryGirl.create(:role_admin)
    end
  end
  
  factory :user, class: User do
    username Faker::Name.name
    password  "foobar"
    password_confirmation "foobar"
    email Faker::Internet.email

    after(:create) do |user|
      user.roles << FactoryGirl.create(:role_user)
    end
  end

  factory :role_admin, class: Role do
    name "admin"
  end

  factory :role_user, class: Role do
    name "user"
  end

  factory :user_role, class: UserRole do
    association :role
    association :user
  end

end