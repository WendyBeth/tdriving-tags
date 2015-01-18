$ ->
  tags = new Bloodhound(
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
    queryTokenizer: Bloodhound.tokenizers.whitespace
    prefetch:
      url: "/tag-suggestions.json"
      filter: (list) ->
        $.map list, (tag) ->
          name: tag
  )

  tags.clearPrefetchCache()
  tags.initialize(true)

  $("#tag_name").typeahead null,
    name: "tags"
    displayKey: "name"
    source: tags.ttAdapter()