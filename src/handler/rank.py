from flask_restful import Resource

from src.api import rank as r_api


class Rank(Resource):
    def get(self):
        try:
            return r_api.rank()
        except Exception as e:
            print 'rank exception: {}'.format(e)

        return 'error'
