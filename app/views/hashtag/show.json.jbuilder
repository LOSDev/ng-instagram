json.total_entries @posts.total_count
json.posts do
  json.array! @posts do |post|
    json.id post.id
    json.image post.image.thumb.url
    json.comments post.comments_count
    json.likes post.likes_count
  end
end
