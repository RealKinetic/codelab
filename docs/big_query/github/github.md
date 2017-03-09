BigQuery and Github
===================

- [Reference Docs](https://cloud.google.com/bigquery/public-data/github)
- [Other cool things people are doing](https://medium.com/google-cloud/github-on-bigquery-analyze-all-the-code-b3576fd2b150#.ua8kr631l)
- [Github Archive](https://www.githubarchive.org/)

## Getting Started

### Setup your Google info if not already done

- Create a [google account](https://accounts.google.com/SignUp) if you don't have one
- Sign into the [Google Cloud Console](http://console.cloud.google.com/) (http://console.cloud.google.com/)

### Github Dataset

Go to the [Github BiqQuery dataset](https://bigquery.cloud.google.com/dataset/bigquery-public-data:github_repos) in the big query console

#### Copy the data set into your project

NOTE: This is needed to run jobs from an app as it requires create job permission which we don't have on the public data sets. You can run queries against those public datasets from the cloud console page.

- Select the `github_repos` dataset under `bigquery-public-data`
- Select the `lanaguages` table
- Click the `Copy Table` button
- Select your cloud project and the `lab` dataset
- Give it a name like `github_lanagues`
- Click `Ok`

This will take a couple of seconds


### Python

[Google Big Query Python Docs](https://cloud.google.com/bigquery/docs/reference/libraries#client-libraries-install-python)

[Google Biq Query Python Client API Docs](https://googlecloudplatform.github.io/google-cloud-python/stable/bigquery-usage.html)

#### Auth

Ensure you've authenticated your API

```sh
$ gcloud auth application-default login
```

##### Interact

###### Install the Google Cloud Python Tools

``` sh
$ pip install google-cloud-bigquery
```

###### Run a python shell

``` sh
$ python
```

###### Create a python client for the bigquery-public-data project

```py
from google.cloud import bigquery
client = bigquery.Client(project='YOUR-CLOUD-PROJECT-ID')
```

###### Load the github dataset

```py
ds = client.dataset("lab")
ds.reload()
```

###### List the tables in the github dataset

```py
for table in ds.list_tables():
    print "Table: {}".format(table.name)
```
