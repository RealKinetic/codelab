from flask_restful import Resource

from src.api import highest_seen as hs_api


class HighestSeen(Resource):
    def get(self):
        return {'highest_seen': hs_api.get_highest_seen()}
