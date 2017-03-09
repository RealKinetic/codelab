from . import session

from src.model import HighestSeen


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
