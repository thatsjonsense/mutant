// Initialize browser size

$(document).ready(function() {

	getBrowserSize();
	
})



function getBrowserSize() {
	var h = $(window).height()
	var w = $(window).width()

	$('#browser_width').val(w)
	$('#browser_height').val(h)

	return (w,h)
}

$(window).resize(getBrowserSize)

// http://developer.chrome.com/extensions/windows.html

function setBrowserSize(w, h) {
	chrome.windows.getLastFocused(function(win) {

		canvas_width = $(window).width()
		canvas_height = $(window).height()
		window_width = win.width
		window_height = win.height

		// Doesn't work perfectly because padding can change
		padding_w = window_width - canvas_width
		padding_h = window_height - canvas_height

		chrome.windows.update(win.id, {
			"width": w + padding_w,
			"height": h + padding_h
		})

	})
	
}