Batch Load Wiki Data Into BigQuery
==================================

[Code Lab Walkthrough](https://codelabs.developers.google.com/codelabs/cloud-bigquery-load-data/index.html)


### Setup and Requirements

[Codelab Page](https://codelabs.developers.google.com/codelabs/cloud-bigquery-load-data/index.html#1)

- Create a [google account](https://accounts.google.com/SignUp) if you don't have one
- Sign into the [Google Cloud Console](http://console.cloud.google.com/) (http://console.cloud.google.com/) to create a cloud project
  - The project name must be unique across all Google projects
  - You need to [enable billing](https://console.developers.google.com/billing) to utilize all cloud services
    - This demo should be less than $1
      - Just make sure to delete your data and turn down services when done
    - However new users are eligible for a [$300 free trial](https://console.developers.google.com/billing/freetrial?hl=en)

### BigQuery Console

[Codelab Page](https://codelabs.developers.google.com/codelabs/cloud-bigquery-load-data/index.html#2)

- You can now go to the cloud console to view Big Query https://console.cloud.google.com/
- Click the hamburger menu at the top left
- Select `BigQuery` under the Big Data section
- You shouldn't see any queries yet

### Load Data into BigQuery

[Codelab Page](https://codelabs.developers.google.com/codelabs/cloud-bigquery-load-data/index.html#3)

#### Create a new dataset

- Click the drop down icon next to the project name
- Click `Create new dataset`
- Give the dataset an ID: `lab`

#### Cloud Shell

For the next section you can either use the web based cloud shell or install the [Google Cloud SDK](https://cloud.google.com/sdk/downloads) and run from your machine

##### Installing local

- Download the SDK here: https://cloud.google.com/sdk/downloads
  - You can follow the directions on that site
- Add the SDK Tools to your path
  - OSX
    $ ./google-cloud-sdk/install.sh
  - Windows
    > .\google-cloud-sdk\install.bat
- Initialize the SDK
  $ ./google-cloud-sdk/bin/gcloud init

###### Components

Once you've installed it locally you can see what components you have installed

    $ gcloud components list

If the BigQuery Command Line Tool is not installed you can install it by running

    $ gcloud components install bq


$ wget https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/pagecounts-20160108-110000.gz

#### Download Wikipedia Dataset

You can go directly to the site to download locally (or with wget/curl). If you're using the cloud shell you will need to use wget.

##### wget

    $ wget https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/pagecounts-20160108-110000.gz

##### Curl

    $ curl -O https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/pagecounts-20160108-110000.gz

##### Site

- Go to the main site: https://dumps.wikimedia.org/other/pagecounts-raw/
- Go to 2016 https://dumps.wikimedia.org/other/pagecounts-raw/2016/
- Go to January https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/
- Find and download this file `pagecounts-20160108-110000.gz`

#### Load the Data Into BigQuery

Now that we have the file we can push it into BigQuery can run this command. Make sure to replace `YourProjectID` with your actual project id

    $ bq load -F" " \
        --quote "" \
        YourProjectID:lab.pagecounts_20160108_11 \
        pagecounts-20160108-110000.gz \
        language,title,requests:integer,content_size:integer

- You can view your project id by running `gcloud config list` and look at the value of `project`

If running locally you maybe prompted to set up your credentials. A link will be given to you in the console. Go ahead an click that which will take you to a browser window. If you have not logged into your google account you will be prompted to do so. If successful you will be given a verification code. Copy that code and paste it back into your console and hit enter.

If you have more than one Google Cloud Project you may also be prompted to select the project you'd like to upload to. Choose the project you'd like by entering the number corresponding to the projectId in the list and hit enter.

- Once running it may take a few minutes. You should see: `Upload Complete` and then the job will start running with something like this in your console:

    Waiting on bqjob_r2d009dff00936867_0000015ab3f56049_1 ... (1s) Current status: RUNNING

- This will eventually finish with the status changing from `RUNNING` to `DONE`

#### Query the Data

You can now go back to the BigQuery console and view the dataset. You can select your data set `pagecounts_20160108_11` listed under `lab`

You can click the details to see the table info:

    Table Size	    560 MB
    Number of Rows	7,371,111
    Creation Time	Mar 9, 2017, 9:48:47 AM
    Last Modified	Mar 9, 2017, 9:48:47 AM

Now you can click `Compose Query` to run a query directly via the console.

Enter this query:

``` sql
SELECT SUM(requests)
FROM [lab.pagecounts_20160108_11]
```

And click `RUN QUERY`

##### Local Console

You can also interact with BigQuery via the [console](https://cloud.google.com/bigquery/bq-command-line-tool)

###### View Table Details

``` sh
$ bq show <project_id>:lab.pagecounts_20160108_11
```

###### Run the Query

``` sh
$ bq query "SELECT SUM(requests) FROM [lab.pagecounts_20160108_11]"
```

Which will result in something like

```sh
Waiting on bqjob_r78ad37814ec84e55_0000015ab401f029_1 ... (0s) Current status: DONE
+----------+
|   f0_    |
+----------+
| 25485553 |
+----------+
```
