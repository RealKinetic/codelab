from google.cloud import bigquery

LIMIT = 100
TIMEOUT_MS = 5000

GET_LANGUAGES_QUERY = """\
SELECT *
FROM [{}:lab.github_languages]
LIMIT {}
"""

GET_LANAGUES_AGGREGATED_QUERY = """\
SELECT language.name, SUM(language.bytes) language.bytes
FROM [{}:lab.github_languages]
GROUP BY language.name
ORDER BY 2 DESC
LIMIT {}
"""


def get_languages(project, dataset, limit=LIMIT):
    q = GET_LANGUAGES_QUERY.format(project, limit)

    results = []
    for repo, lang, btes in irun(project, dataset, q):
        results.append({"repo": repo, "language": lang, "bytes": btes})

    return results


def get_languaes_aggregated(project, dataset, limit=LIMIT):
    q = GET_LANAGUES_AGGREGATED_QUERY.format(project, limit)

    results = []
    for res in irun(project, dataset, q):
        results.append(res)

    return results


def irun(project, dataset, query):
    client = bigquery.Client(project=project)

    ds = client.dataset(dataset)
    ds.reload()

    query = client.run_sync_query(query)
    query.timeout_ms = TIMEOUT_MS
    query.run()             # API request

    page_token = None

    while True:
        rows, total_rows, page_token = query.fetch_data(
            max_results=10,
            page_token=page_token)

        for row in rows:
            yield row

        if not page_token:
            break
