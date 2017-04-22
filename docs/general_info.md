## Documentation

### BigQuery

- [Github Data Docs](docs/big_query/github/github.md)
- [Uploading Wiki Data Codelab Docs](docs/big_query/wiki/wiki.md)


## Setup

### Cloud

#### Setup a Google Cloud Project

- Create a [google account](https://accounts.google.com/SignUp) if you don't have one
- Sign into the [Google Cloud Console](http://console.cloud.google.com/) (http://console.cloud.google.com/) to create a cloud project
  - The project name must be unique across all Google projects
  - You need to [enable billing](https://console.developers.google.com/billing) to utilize all cloud services
    - Make sure to delete your data and turn down services when not using them
    - However new users are eligible for a [$300 free trial](https://console.developers.google.com/billing/freetrial?hl=en)

### Local

#### Install Google Cloud SDK

- Download the SDK here: https://cloud.google.com/sdk/downloads
  - You can follow the directions on that site
- Add the SDK Tools to your path
  - OSX
    $ ./google-cloud-sdk/install.sh
  - Windows
    > .\google-cloud-sdk\install.bat
- Initialize the SDK
  $ ./google-cloud-sdk/bin/gcloud init

##### Components

Once you've installed it locally you can see what components you have installed

    $ gcloud components list

#### Install MySQL or MySQL Connector

To run local or even install the python mysql package (annoying we know) you need to either have mysql installed on your local machine or the mysql connector.

##### MySQL

```sh
$ brew install mysql
```

or

##### MySQL Connector

``` sh
$ brew install mysql-connector-c
```

##### Configure MySQL

In `src/config/envs/deployed.py` update the config options for your mysql database connection.

- Replace USER_NAME with your mysql user's login name
- Replace PASSWORD with your mysql user's password
- Replace DATABASE_NAME with your mysql database name
- Replace PROJECT_ID with your google cloud project id
- Replace REGION with the region your SQL instance is running in

So what was:

``` py
DSN = (
    'mysql+mysqldb://USER_NAME:PASSWORD@/DATABASE_NAME?unix_socket=/cloudsql/'
    'PROJECT_ID:REGION:DATABASE_NAME'
)
```

Should now look something like:

``` py
DSN = (
    'mysql+mysqldb://root:mypwd@/mydb?unix_socket=/cloudsql/'
    'my_gcp_project_id:us-central1:mydb'
)
`

#### Install Dependencies

``` sh
$ make install
```

#### Web Client Setup

This is optional. We have committed the generated client to the repo under `static/generated`

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

- Application: [http://localhost:8080/](http://localhost:8080/)
- Rank: [http://localhost:8080/rank](http://localhost:8080/rank)
- Natural Language: [http://localhost:8080/natural_language](http://localhost:8080/natural_language)
- Hacker News: [http://localhost:8080/hacker_news](http://localhost:8080/hacker_news)
- Highest Seen: [http://localhost:8080/highest_seen](http://localhost:8080/highest_seen)
- Big Query
  - Language List: [http://localhost:8080/big_query/languages](http://localhost:8080/big_query/languages)
  - Aggregated Languages by Bytes: [http://localhost:8080/big_query/languages/aggregated](http://localhost:8080/big_query/languages/aggregated)

## Deploy

```sh
$ gcloud app deploy app.yaml
```
