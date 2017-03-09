from googleapiclient import discovery

from . import get_google_credentials
from . import session
from src.model import Word

_client = None


class Entity(object):
    def __init__(self, response):
        self.type_ = response.get('type')
        self.salience = response.get('salience')
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


def persist_analysis(item, response):
    """Persists item and response data to a datasource for further analysis.

    :param item: hacker news item information
    :type item: src.api.hacker_news.Item
    :param response: natural language response
    :type response: Response
    """
    s = session()
    for entity in response.entities:
        word = Word()
        word.item_id = item.id
        word.salience = entity.salience
        word.word = entity.name
        word.type_ = entity.type_
        s.add(word)

    s.commit()
