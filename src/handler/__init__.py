from flask import Flask
from flask_restful import Api

from hacker_news import HackerNews
from highest_seen import HighestSeen
from natural_langage import NaturalLanguage

app = Flask(__name__)
api = Api(app)

api.add_resource(HighestSeen, '/highest_seen')
api.add_resource(NaturalLanguage, '/natural_language')
api.add_resource(HackerNews, '/hacker_news')
