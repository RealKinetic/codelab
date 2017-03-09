Google Code Lab
===============

## Documentation

### BigQuery

- [Github Data Docs](docs/big_query/github/github.md)
- [Uploading Wiki Data Codelab Docs](docs/big_query/wiki/wiki.md)


## Setup

### Local

#### Install Dependencies

``` sh
$ make install
```

#### Web Client Setup

##### Install Elm

[Directions Here](https://guide.elm-lang.org/install.html)

##### Generate the Client

``` sh
$ make generate-client
```

#### Run the server and app

``` sh
$ make run
```

#### View App and Endpoints

- Application: http://localhost:8080/
- Rank: http://localhost:8080/rank
- Natural Language: http://localhost:8080/natural_language
- Hacker News: http://localhost:8080/hacker_news
- Highest Seen: http://localhost:8080/highest_seen
- Big Query
  - Language List: http://localhost:8080/big_query/languages
  - Aggregated Languages by Bytes: http://localhost:8080/big_query/languages/aggregated

## Deply

```sh
$ gcloud app deploy app.yaml
```
