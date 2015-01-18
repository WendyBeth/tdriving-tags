$ ->
  tags = gon.tags.map((tag) ->
    tag["link"] = "/tags/" + tag["link"]
    tag
  )

  $("#tag-cloud").jQCloud tags
  return