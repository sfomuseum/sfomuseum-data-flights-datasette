FROM datasetteproject/datasette
RUN apt update && apt install -y wget bzip2
# start of this is the wrong way to do it... but you know if
# I have three weeks to figure out how to wire wof-list-repos
# in to this Dockerfile... (20190207/thisisaaronland)
RUN wget -q https://millsfield.sfomuseum.org/distributions/sqlite/sfomuseum-data-flights-2019-01-latest.db.bz2
RUN bunzip2 sfomuseum-data-flights-2019-01-latest.db.bz2
RUN wget -q https://millsfield.sfomuseum.org/distributions/sqlite/sfomuseum-data-flights-2019-02-latest.db.bz2
RUN bunzip2 sfomuseum-data-flights-2019-02-latest.db.bz2
# end of this is the wrong way to do it...
RUN datasette inspect --inspect-file=inspect.json sfomuseum-data-flights-2019-01-latest.db sfomuseum-data-flights-2019-02-latest.db
EXPOSE 8001
CMD ["datasette", "-h", "0.0.0.0", "--inspect-file", "inspect.json", "-p", "8001", "sfomuseum-data-flights-2019-01-latest.db", "sfomuseum-data-flights-2019-02-latest.db", "--cors"]