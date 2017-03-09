from googleapiclient import discovery

from . import get_google_credentials


_client = None


class Entity(object):
    def __init__(self, response):
        self.type_ = response.get('type')
        self.saliance = response.get('saliance')
        self.name = response.get('name')


class Response(object):
    def __init__(self, response):
        self.language = response.get('language')
        self.entities = []
        for mp in response.get('entities', []):
            self.entities.append(Entity(mp))


def get_client():
    global _client

    if not _client:
        _client = discovery.build(
            'language', 'v1', credentials=get_google_credentials()
        )

    return _client


def analyze_text(text, encoding='UTF8'):
    """Makes a request against the natural language service and returns the
    results.

    :param text: text to analyze
    :type text: str
    :param encoding: encoding of the text
    :type encoding: str
    :return:
    """
    body = {
        'document': {
            'type': 'PLAIN_TEXT',
            'content': text,
        },
        'encoding_type': encoding,
    }
    client = get_client()
    request = client.documents().analyzeEntities(body=body)
    response = request.execute()
    return Response(response)
