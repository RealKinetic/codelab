from google.appengine.api import urlfetch


# base url for all requests
HOST_URL = "https://hacker-news.firebaseio.com/v0/"

GET_HIGHEST_URL = HOST_URL + "maxitem.json?print=pretty"


class HackerNewsException(Exception):
    pass


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
