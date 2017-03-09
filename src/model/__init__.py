from sqlalchemy import Column, Float, Integer, String
from sqlalchemy.ext.declarative import declarative_base


Base = declarative_base()


class HighestSeen(Base):
    __tablename__ = 'highest_seen'

    id = Column(Integer, primary_key=True, autoincrement=True)
    highest_seen = Column(Integer, nullable=False)


class Word(Base):
    __tablename__ = 'words'

    id = Column(Integer, primary_key=True, autoincrement=True)
    word = Column(String(255), nullable=False, )
    salience = Column(Float)
    item_id = Column(Integer, nullable=False)
    type_ = Column(String(255))
