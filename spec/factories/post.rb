FactoryGirl.define do
  factory :post do
    description {Faker::Hipster.sentence}
    user
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app', 'assets', 'images', 'image_12.jpeg')) }
  end

end
