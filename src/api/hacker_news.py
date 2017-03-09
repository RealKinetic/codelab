import json

from google.appengine.api import urlfetch


# base url for all requests
HOST_URL = "https://hacker-news.firebaseio.com/v0/"

GET_HIGHEST_URL = HOST_URL + "maxitem.json?print=pretty"

GET_ITEM_URL = HOST_URL + "item/{}.json?print=pretty"


class HackerNewsException(Exception):
    pass


class Item(object):
    def __init__(self, response):
        self.id = response.get('id')
        self.title = response.get('title')
        self.type_ = response.get('type')
        self.score = response.get('score')
        self.text = response.get('text')

    def get_text(self):
        return self.title or self.text


def get_highest_item_id():
    """Returns the highest item id on hacker news.

    :return: highest item id
    :rtype: int or long
    """
    try:
        result = urlfetch.fetch(GET_HIGHEST_URL)
        if result.status_code == 200:
            return int(result.content)
        else:
            raise HackerNewsException('bad result')
    except urlfetch.Error as e:
        raise HackerNewsException(repr(e))


def get_item(item_id):
    """Retrieves an item based on the specified id.

    :param item_id: id of the item in question
    :type item_id: int or long
    :return: the resulting item or None
    :rtype: Item or None
    """
    url = GET_ITEM_URL.format(item_id)
    try:
        result = urlfetch.fetch(url)
        if result.status_code == 200:
            return Item(json.loads(result.content))
        else:
            raise HackerNewsException('bad result')
    except urlfetch.Error as e:
        raise HackerNewsException(repr(e))
