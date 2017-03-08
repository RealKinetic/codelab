from sqlalchemy import Column, Integer
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class HighestSeen(Base):
    __tablename__ = 'highest_seen'

    id = Column(Integer, primary_key=True, autoincrement=True)
    highest_seen = Column(Integer, nullable=False)
