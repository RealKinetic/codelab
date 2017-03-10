from flask_restful import Resource

from src.api import highest_seen as hs_api


class HighestSeen(Resource):
    def get(self):
        return { 'result': hs_api.get_average() }
