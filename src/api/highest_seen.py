from sqlalchemy import func

from . import session

from src.model import HighestSeen, Word


def get_highest_seen():
    """Returns the highest seen hacker news id that's persisted.

    :return: highest seen persisted id
    :rtype: int or long
    """
    s = session()
    h = s.query(HighestSeen).order_by(HighestSeen.highest_seen.desc()).first()
    s.commit()

    if not h:
        return -1

    return h.highest_seen


def set_highest_seen(highest_seen):
    """Sets the highest seen persisted id.

    :param highest_seen: highest seen id
    :type highest_seen: int or long
    """
    h = HighestSeen()
    h.highest_seen = highest_seen

    s = session()
    s.add(h)
    s.commit()


def get_average():
    """Retrieves salience grouped by words.

    :return:
    """
    s = session()
    h = s.query(Word.word, func.avg(Word.salience)).group_by(Word.word).all()
    s.commit()

    result = [{'word': res[0], 'average': res[1]} for res in h]

    return result
