from flask import Flask
from flask_restful import Api

from big_query import BigQueryLanguages
from big_query import BigQueryAggLanguages
from hacker_news import HackerNews
from highest_seen import HighestSeen
from natural_langage import NaturalLanguage
from rank import Rank


app = Flask(__name__)
api = Api(app)


api.add_resource(HighestSeen, '/highest_seen')
api.add_resource(NaturalLanguage, '/natural_language')
api.add_resource(HackerNews, '/hacker_news')
api.add_resource(Rank, '/rank')
api.add_resource(BigQueryLanguages, '/big_query/languages')
api.add_resource(BigQueryAggLanguages, '/big_query/languages/aggregated')
