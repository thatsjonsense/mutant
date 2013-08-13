// Sidekick for tracking browser width/height

settings.add({
	name: 'width',
	get: getBrowserWidth,
	set: setBrowserWidth,
	listen: $(window).resize
})

settings.add({
	name: 'height',
	get: getBrowserHeight,
	set: setBrowserHeight,
	listen: $(window).resize
})

function getBrowserWidth() {
	return $(window).width()
}

function getBrowserHeight() {
	return $(window).height()
}