import json

from flask_restful import Resource

from src.api import natural_language as nl_api


class NaturalLanguage(Resource):
    def get(self):
        try:
            response = nl_api.analyze_text('nine inch nails is the best band ever')
            dumped = json.dumps(response)
            return dumped
        except Exception as e:
            print 'E!: {}'.format(e)

        return "hello"
