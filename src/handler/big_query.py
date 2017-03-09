from flask_restful import Resource
from google.appengine.api.app_identity import get_application_id

from src.api import big_query as bq_api


DATASET = "lab"


def _get_app_name(default):
    appname = get_application_id()
    if not appname or appname.lower() == 'none':
        return default

    return appname


class BigQueryLanguages(Resource):

    def get(self):
        try:
            appname = _get_app_name("rk-playground")
            result = bq_api.get_languages(appname, DATASET, limit=50)
            return { 'result': result }
        except Exception as e:
            print 'E!: {}'.format(e)

        return 'error'


class BigQueryAggLanguages(Resource):

    def get(self):
        try:
            appname = _get_app_name("rk-playground")

            result = bq_api.get_languaes_aggregated(appname, DATASET, limit=50)
            return { 'result': result }
        except Exception as e:
            print 'E!: {}'.format(e)

        return 'error'
