MUTANT
======


To add a new CSS or Javascript file
---------------------

1. Open manifest.json
2. Under the "web_accessible_resources" key, add your filename
3. Open rules.sjon
4. Create a new line for your rule. The key is a string to search for in the URL. You can use a simple string like "nytimes.com", or a regular expression like "(google|bing).com"