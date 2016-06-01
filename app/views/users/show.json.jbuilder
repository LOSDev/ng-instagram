json.id @user.id
json.username @user.username
json.bio @user.bio
json.avatar do
  json.medium do
    json.url @user.avatar.medium.url
  end
end
json.slug @user.slug
json.followers @user.followed_relationships_count
json.following @user.following_relationships_count
json.total_entries @user.posts.count
