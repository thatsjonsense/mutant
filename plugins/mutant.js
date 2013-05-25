// Debugging

DEBUG = true

function log(message) {
	if(DEBUG) {
		console.log(message)
	}
}

// Get URL parameters

URL = $.url().param()
URL.raw = $.url().attr('source')
URL.domain = $.url().attr('host')
URL.anchor = $.url().attr('fragment')


// Step through each rule in rules.json, adding the JS/CSS files that apply

CSS_FILES = []
JS_FILES = []

_.each(RULES,function(files,rule){
	var re = new RegExp(rule)
	if (re.test(URL.raw)) {
		log('URL ' + URL.raw + ' matched on rule ' + rule)
		
		JS_FILES = _.union(
			_.filter(files, function(file) {return /.js$/.test(file)}),
			_.filter(files, function(file) {return /.json$/.test(file)}),
			JS_FILES
		)

		CSS_FILES = _.union(
			_.filter(files, function(file) {return /.css$/.test(file)}),
			_.filter(files, function(file) {return /.less$/.test(file)}),
			CSS_FILES
		)


	} else {
		log('URL ' + URL.raw + ' did not match on rule ' + rule)
	}
})


// Load CSS files via LESS
_.each(CSS_FILES,function(filename){

	var tag = document.createElement('link');
	tag.rel = 'stylesheet';
	tag.type = 'text/less';
	tag.href = chrome.extension.getURL(filename);
	less.sheets.push(tag);
	less.refresh();
	log('Loaded ' + filename)
})

// Load Javascript and JSON files

_.each(JS_FILES,function(filename){

	// todo: make this synchronous
	var src = chrome.extension.getURL(filename) + '?' + Math.random() //bypass cache
	$.get(src,function(file){
		eval(file)
	})

	log('Loaded ' + filename)

})