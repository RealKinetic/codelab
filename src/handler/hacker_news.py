from flask_restful import Resource

from src.api import hacker_news as hn_api


class HackerNews(Resource):
    def get(self):
        try:
            item = hn_api.get_item(13825823)
            print 'item: {}'.format(item.__dict__)
            return 'ok'
        except Exception as e:
            print 'E!: {}'.format(e)

        return 'error'
