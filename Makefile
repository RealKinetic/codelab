generate-client:
	(cd elm/src && elm-make Main.elm --yes --output ../../static/generated/js/codelab.js)

run:
	dev_appserver.py app.yaml
