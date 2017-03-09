from google.cloud import bigquery

# SELECT language.name, SUM(language.bytes) language.bytes
# FROM [bigquery-public-data:github_repos.languages]
# GROUP BY language.name
# ORDER BY 2 DESC
# LIMIT 20

APP_NAME = "rk-playground"
DATASET = "lab"

LIMIT = 10
TIMEOUT_MS = 5000

GET_LANGUAGES_QUERY = """\
SELECT *
FROM `{}.lab.github_languages`
LIMIT {}
"""


def main():
    client = bigquery.Client(project=APP_NAME)

    ds = client.dataset(DATASET)
    print "Loading github dataset ..."
    ds.reload()

    print "Github Dataset name: {} and id: {}".format(ds.name, ds.dataset_id)

    print "\nList the github dataset tables"
    print 40 * "-"
    for table in ds.list_tables():
        print "Table: {}".format(table.name)
    print 40 * "-"

    print "\nRun some queries"
    query = client.run_sync_query(GET_LANGUAGES_QUERY.format(APP_NAME, LIMIT))
    query.use_legacy_sql = False
    query.timeout_ms = TIMEOUT_MS
    query.run()             # API request

    page_token = None

    while True:
        rows, total_rows, page_token = query.fetch_data(
            max_results=10,
            page_token=page_token)

        for row in rows:
            print(row)

        if not page_token:
            break


if __name__ == '__main__':
    main()
