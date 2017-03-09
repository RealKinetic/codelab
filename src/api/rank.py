import hacker_news
import highest_seen
import natural_language


def rank():
    """Initiates the loading of a new entity, analyze it, and persist the result.

    :return: item id analyzed, if any
    :rtype: int or long or None
    """
    highest = highest_seen.get_highest_seen()
    newest = hacker_news.get_highest_item_id()
    if newest <= highest:
        return highest

    item = hacker_news.get_item(newest)
    response = natural_language.analyze_text(item.get_text())
    natural_language.persist_analysis(item, response)
    return newest
