# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating Users..."
20.times {User.create(email: Faker::Internet.email, password: Faker::Internet.password,
                      username: Faker::Internet.user_name(nil, %w(- _)), bio: Faker::Hipster.sentence,
                      avatar: File.new("#{Rails.root}/app/assets/images/image_#{rand(1..32)}.jpeg")
                  )}


puts "Creating Posts..."
230.times do |n|
  puts "Creating Post #{n} of 230" if n % 10 == 0
  Post.create(image: File.new("#{Rails.root}/app/assets/images/image_#{rand(1..32)}.jpeg"),
    description: "#{Faker::Hipster.word} ##{Faker::Hipster.word} #{Faker::Hipster.word}",
    user_id: rand(1..User.count)
  )
end

puts "Creating Comments..."
555.times{Comment.create(post_id: rand(1..Post.count), user_id: rand(1..User.count), content: Faker::Hipster.sentence)}

puts "Creating Likes..."
555.times{Like.create(post_id: rand(1..Post.count), user_id: rand(1..User.count))}

puts "Creating Followers..."
200.times{
  FollowingRelationship.create(follower_id:rand(1..User.count), followed_id:rand(1..User.count))
}
