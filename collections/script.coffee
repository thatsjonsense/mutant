# Resources
###########

# source: http://metro.windowswiki.info/mi/
# album: http://imgur.com/a/OFE2N

icons =
	plus: 'http://i.imgur.com/hMb7oIo.png'
	x: 'http://i.imgur.com/fgCrKfn.png'
	fav: 'http://i.imgur.com/2Ku4QsV.png'
	favadd: 'http://i.imgur.com/GgqxQti.png'


query = URL.q

# Reading/writing to localStorage
#################################

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

# Rendering tags
################
showTagged = (div_image) ->
	log div_image
	div_tags = div_image.find('.tags')
	log div_tags
	div_tags.prepend("<div class='tag'><img src='#{icons.fav}'</div>")
	div_tags.find('.add img').attr('src',icons.x)
	div_image.addClass('saved')

showUntagged = (div_image) ->
	div_tags = div_image.find('.tags')
	div_tags.find('.tag').remove()
	div_tags.find('.add img').attr('src',icons.favadd)
	div_image.removeClass('saved')


# Support tagging stuff
#######################
makeTaggable = (images) ->
	images.prepend("<div class='tags'></div>")
	images.find('.tags').html("<div class='add'><img src='#{icons.favadd}'></div>")

	images.mouseenter ->
		$(@).find('.tags .add').fadeIn(100)

	images.mouseleave ->
		$(@).find('.tags .add').fadeOut(100)

	images.find('.tags .add').click ->
		
		div_tags = $(@).closest('.tags')
		div_image = $(@).closest('.dg_u')
		image_id = div_image.find('a').attr('ihk')

		# Toggle	
		if div_tags.find('.tag').length
			log "Removing result #{image_id} for query #{query}"
			Storage.removeTag(query,image_id,'saved')
			showUntagged(div_image)
		else
			log "Saving result #{image_id} for query #{query}"
			Storage.addTag(query,image_id,'saved')
			showTagged(div_image)



# Load saved stuff
##################
loadTags = (images) ->
	tagged_items = Storage.getTags(query)

	for image_id, tags of tagged_items when tags.length
		dgu = images.has("a[ihk='#{image_id}']")
		if dgu
			showTagged(dgu)


# Add handlers every time we load in more images
#################
setup = ->
	untaggable = $('.dg_u').not('.taggable')
	makeTaggable(untaggable)
	loadTags(untaggable)
	untaggable.addClass('taggable')


setup()
$(window).scroll -> setup()






