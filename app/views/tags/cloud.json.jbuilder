json.array! Tag.approved do |tag|
  json.text    tag.name
  json.weight  tag.videos.count
  json.link    tag.id
end