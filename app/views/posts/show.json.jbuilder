json.id @post.id
json.description @post.description
json.time_ago time_ago_in_words(@post.created_at)
json.user do
  json.id @post.user.id
  json.slug @post.user.slug
  json.username @post.user.username
  json.avatar do
    json.thumb do
      json.url @post.user.avatar.thumb.url
    end
  end

end
json.image @post.image.medium.url
json.likes @post.likes.count
json.like @like

json.next_id @post.next_id
json.previous_id @post.previous_id
