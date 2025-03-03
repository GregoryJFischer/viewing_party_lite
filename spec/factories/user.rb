password_holder = Faker::Internet.password

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { password_holder }
    password_confirmation { password_holder }
  end
end
