// Add more files here. Don't forget to include them in manifest.json!

CSS_FILES = ['style.css']
JS_FILES = ['script.js']
DEBUG = false

// Get URL parameters

URL = $.url().param()
URL.raw = $.url().attr('source')
URL.domain = $.url().attr('host')
URL.anchor = $.url().attr('fragment')

// Reload CSS

_.each(CSS_FILES,function(filename){

	var tag = document.createElement('link');
	tag.rel = 'stylesheet';
	tag.type = 'text/less';
	tag.href = chrome.extension.getURL(filename);
	less.sheets.push(tag);
	less.refresh();
	if(DEBUG) {console.log('Loaded ' + filename)}
})

// Reload scripts

_.each(JS_FILES,function(filename){

	var src = chrome.extension.getURL(filename) + '?' + Math.random() //bypass cache
	$.get(src,function(file){
		eval(file)
	})

	if(DEBUG) {console.log('Loaded ' + filename)}

})
	
// Don't add code below this point!
// --------------------------------