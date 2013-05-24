SETTINGS = URL

if (SETTINGS.color == 'white') {
	$('body').addClass('cluster_white')
} else if (SETTINGS.color == 'gray') {
	$('body').addClass('cluster_gray')
} else if (SETTINGS.color == 'dark') {
	// do nothing, it already is
}

if(SETTINGS.underline) {
	$('body').addClass('cluster_underline')
}

if(SETTINGS.tight) {
	$('body').addClass('cluster_tight')
}

if (SETTINGS.num_images) {

	var MAX = 245;
	var w = Math.floor(245 / SETTINGS.num_images)
	var h = w;
	$('#rr_cluster img').each(function(index) {
		var oldsrc = $(this).attr('src');
		var newsrc = oldsrc;
		var newsrc = newsrc.replace('w=81&h=81','w=' + w + '&h=' + h)
		var newsrc = newsrc.replace('&dc=3','&dc=' + SETTINGS.num_images)
		$(this).attr('src',newsrc)
		$(this).css('height','auto')
		$(this).css('width','auto')
	})

	//url: http://ts3.mm.bing.net/th?q=Funny+Cat+Quotes&w=81&h=81&c=7&bw=1&bc=FFFFFF&pid=1.7&mkt=en-US&adlt=moderate&dc=3&mw=245
	//new: http://ts3.mm.bing.net/th?q=Funny+Cat+Quotes&w=81&h=81&c=7&bw=1&bc=FFFFFF&pid=1.7&mkt=en-US&adlt=moderate&dc=4&mw=245

}

if (SETTINGS.overlap) {
	$('body').addClass('cluster_overlap')
}