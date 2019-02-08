docker:
	docker build -t sfomuseum-data-flights .

run:
	docker run -it -p 8080:8001 sfomuseum-data-flights
