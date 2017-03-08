generate-client:
	(cd elm/src && elm-make Main.elm --yes --output ../../static/generated/cerebral.js)
