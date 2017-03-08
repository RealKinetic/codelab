from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from src.config import get_env
from src.model import Base

_sessionfactory = None
_engine = None


def session():
    """Returns SQLAlchemy session.
    """
    global _sessionfactory
    if not _sessionfactory:
        global _engine

        _engine = create_engine(get_env('DSN'))
        _sessionfactory = sessionmaker(bind=_engine)
        Base.metadata.create_all(_engine)

    return _sessionfactory()
