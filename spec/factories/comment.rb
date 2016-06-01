FactoryGirl.define do
  factory :comment do
    content {Faker::Hipster.sentence}
    post
    user
  end

end
