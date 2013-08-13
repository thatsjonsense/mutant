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
showTagged = (image_id) ->
	div_image = findImageDivs(image_id).not('.saved')

	div_tags = div_image.find('.tags')
	
	div_tags.prepend("<div class='tag'><img src='#{icons.fav}'</div>")
	div_tags.find('.add img').attr('src',icons.x)
	div_image.addClass('saved')

	img = div_image.clone(true)
	$('.cart').append(img)
	img.mouseleave()
	




showUntagged = (image_id) ->
	div_image = findImageDivs(image_id)
	div_tags = div_image.find('.tags')
	div_tags.find('.tag').remove()
	div_tags.find('.add img').attr('src',icons.favadd)
	div_image.removeClass('saved')

	$('.cart').find(div_image).remove()



# Cart
######################
createCart = ->
	$('body').append("<div class='cart'><h1>Saved images</h1></div>")


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
			showUntagged(image_id)
		else
			log "Saving result #{image_id} for query #{query}"
			Storage.addTag(query,image_id,'saved')
			showTagged(image_id)



# Load saved stuff
##################
findImageDivs = (image_id) ->
	$('.dg_u').has("a[ihk='#{image_id}']")


loadTags = (images) ->
	tagged_items = Storage.getTags(query)

	for image_id, tags of tagged_items when tags.length
		showTagged(image_id,images)


# Add handlers every time we load in more images
#################
setup = ->
	untaggable = $('.dg_u').not('.taggable')

	untaggable.addClass('taggable')

	makeTaggable(untaggable)

	loadTags(untaggable)





createCart()


setup()
$(window).scroll -> setup()






