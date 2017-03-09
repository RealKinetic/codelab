import os

from src.config.envs import deployed
from src.config.envs import local

INITIALIZED = False

CONFIG = {}


def get_env(key):
    """Returns the envar for the provided key, if it exists, else None.

    :param key: name of the envar
    :type key: str
    :return: value of the envar
    :rtype: object or None
    """
    global INITIALIZED
    if not INITIALIZED:
        global CONFIG
        if not os.getenv('SERVER_SOFTWARE', '').startswith('Google App Engine/'):
            CONFIG['DSN'] = local.DSN
        else:
            CONFIG['DSN'] = deployed.DSN

        INITIALIZED = True

    return CONFIG.get(key)
