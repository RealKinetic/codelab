Google Code Lab
===============

## About

In this codelab, we will be building an application that combines several GCP
services to build a fully functioning application. The application we will
build utilizes [Google App Engine][GAE] for our user traffic and backend
processing tasks, [Google Cloud SQL][CSQL] for storage, and [Google Cloud
NL][CNL] for sentiment analysis.

This codelab builds upon some of [Google's Codelabs][GCL]:

- [Getting Started with App Engine (Python)][GCL.GAE]
- [Entity and Sentiment Analysis with the Natural Language API][GCL.NL]
- [Create a Managed MySQL database with Cloud SQL][GCL.SQL]


## How to Use this Codelab

This codelab may be followed along by cloning this repository, then following
this README. Once you are past [STEP
2](#step-2-getting-started-with-google-cloud-sql-mysql), if you are struggling
with a step, step-3 for example, you may checkout the branch named STEP-3.

This codelab should be completed using the Google Cloud Shell. This is what all
of the Google provided codelabs recommend using as well. Cloud Shell is
accessed from the Google Cloud Console, by clicking the button to the right of
the search box:

![Activate Google Cloud Shell](./docs/img/ActiveGoogleCloudShell.png)

I recommend working through all exercises in the Google Codelabs, and I suggest
selecting Novice. Your settings for each codelab should look something like
this:

![Google Codelab Settings](./docs/img/CodelabSettings.png)

You may use an existing Cloud Project or create a new Cloud Project for use
during this codelab. Please note, if you use Qwiklabs your project will be
reset after each codelab - for this reason I recommend using your own Cloud
Project.

NOTE: This codelab might cost between $1 and $3 in compute resources.


## STEP 0: Getting Started with Google App Engine

We will use [Google App Engine][GAE] to serve user requests, perform backend
processing, and to host our static resources.

Work through Google's [Getting Started with App Engine (Python)][GCL.GAE]
codelab, then move on to [STEP 1](#step-1-getting-started-with-google-cloud-natural-language-api).


## STEP 1: Getting Started with Google Cloud Natural Language API

We will use [Google Cloud Natural Language API][CNL] to conduct sentiment
analysis on entities we fetch from [Hacker News][HN]. In this step, we will
introduce you to the basics of the APIs.

Work through Google's [Entity and Sentiment Analysis with the Natural Language
API][GCL.NL] codelab, then move on to [STEP 2](#step-2-getting-started-with-google-cloud-sql-mysql).

NOTE: Do not forget to enable the Cloud Natural Language API. To do this, under
API Manager, goto Library, then find Cloud Natural Language and click it. Click
enable.


## STEP 2: Getting Started with Google Cloud SQL MySQL

We will use [Google Cloud SQL][CSQL] to store the results of our sentiment
analysis.

Work through Google's [Create a Managed MySQL database with Cloud SQL][GCL.SQL]
codelab, then move on to [STEP 3](#step-3-putting-the-pieces-together).

NOTE: Select Second Generation when creating your instance.

## STEP 3: Putting the Pieces Together



[GAE]: https://cloud.google.com/appengine/
[CSQL]: https://cloud.google.com/sql/docs/mysql/
[CNL]: https://cloud.google.com/natural-language/
[GCL]: https://codelabs.developers.google.com/cloud?cat=Cloud
[GCL.GAE]: https://codelabs.developers.google.com/codelabs/cloud-app-engine-python/index.html
[GCL.NL]: https://codelabs.developers.google.com/codelabs/cloud-nl-intro/index.html
[GCL.SQL]: https://codelabs.developers.google.com/codelabs/cloud-create-cloud-sql-db/index.html
[HN]: https://news.ycombinator.com/

