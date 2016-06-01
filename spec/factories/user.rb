FactoryGirl.define do
  factory :user do
    username
    email
    password "password"
    bio {Faker::Hipster.sentence}
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'image_12.jpeg')) }
  end
  sequence :email do |n|
    "user#{n}@example.com"
  end
  sequence :username do |n|
    "#{Faker::Name.first_name}_n"
  end
end
