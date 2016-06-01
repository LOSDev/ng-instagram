json.total_entries @comments.total_count
json.comments do
  json.array! @comments do |comment|
    json.id comment.id
    json.content comment.content
    json.user comment.user, :username, :slug, :id
  end
end
