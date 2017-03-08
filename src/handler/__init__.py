from flask import Flask
from flask_restful import Api

from highest_seen import HighestSeen

app = Flask(__name__)
api = Api(app)

api.add_resource(HighestSeen, '/highest_seen')
