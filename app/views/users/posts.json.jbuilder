json.array! @posts do |post|
  json.id post.id
  json.image post.image.thumb.url
  json.comments post.comments.size
  json.likes post.likes.size

end
