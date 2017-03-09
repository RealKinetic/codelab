from flask_restful import Resource

from src.api import hacker_news as hn_api


class HackerNews(Resource):
    def get(self):
        return hn_api.get_highest_item_id()
