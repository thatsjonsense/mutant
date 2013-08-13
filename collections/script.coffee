# source: http://metro.windowswiki.info/mi/
# album: http://imgur.com/a/OFE2N

icons =
	plus: 'http://i.imgur.com/hMb7oIo.png'
	x: 'http://i.imgur.com/fgCrKfn.png'
	fav: 'http://i.imgur.com/2Ku4QsV.png'
	favadd: 'http://i.imgur.com/GgqxQti.png'

$('.dg_u').prepend("<div class='tags'></div>")
$('.tags').html("<div class='add'><img src='#{icons.favadd}'></div>")

$('.tags .add').click ->
	
	# Toggle
	tags = $(@).closest('.tags')
	query = URL.q
	image = $(@).closest('.dg_u').find('a').attr('ihk')

	
	if tags.find('.tag').length
		log "Removing result #{image} for query #{query}"
		Storage.removeTag(query,image,'saved')
		tags.find('.tag').remove()
		tags.find('.add img').attr('src',icons.favadd)
	else
		log "Saving result #{image} for query #{query}"
		Storage.addTag(query,image,'saved')
		tags.prepend("<div class='tag'><img src='#{icons.fav}'</div>")
		tags.find('.add img').attr('src',icons.x)


	

$('.dg_u').mouseenter ->
	$(@).find('.tags .add').fadeIn(100)

$('.dg_u').mouseleave ->
	$(@).find('.tags .add').fadeOut(100)



if not store.get("biSave")?
	store.set("biSave",{})


class Storage

	@namespace: 'biSave'

	@removeTag: (query,item,tag) ->
		@removeTags(query,item,[tag])

	@removeTags: (query,item,tags) ->
		items = @get(query) ? {}
		items[item] = _.difference(items[item], tags)
		@set(query,items)

	@getTags: (query) ->
		@get(query) ? {}

	@hasTag: (query) ->
		@get(query)?

	@addTag: (query,item,tag) ->
		@addTags(query,item,[tag])

	@addTags: (query,item,tags) ->
		items = @get(query) ? {}
		items[item] = _.union(items[item] ? [], tags)
		@set(query,items)

	@get: (key) ->
		value = store.get("#{@namespace}_#{key}")

	@set: (key,value) ->
		store.set("#{@namespace}_#{key}",value)


