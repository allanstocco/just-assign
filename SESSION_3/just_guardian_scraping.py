import requests
import json
from bs4 import BeautifulSoup as bs
import sqlite3

con = sqlite3.connect("guardian_scrap_database.sqlite3")
cur = con.cursor()

cur.execute("CREATE TABLE guardian(title, text, url)")


articles_guardian = requests.get("https://www.theguardian.com/uk")

guardian_html = bs(articles_guardian.content, "html.parser")

article_title_tags = guardian_html.find_all(
    'span', attrs={'class': 'fc-item__kicker'}, text=True)
article_text_tags = guardian_html.find_all(
    'span', attrs={'class': 'js-headline-text'}, text=True)
article_href_tags = guardian_html.find_all(
    'a', attrs={'class': 'u-faux-block-link__overlay js-headline-text'}, href=True)


def select_data(article, text, href):
    return [
        article.text,
        text.text,
        href['href']
    ]


guardian_articles_data = [select_data(article, text, href) for article, text, href in zip(
    article_title_tags, article_text_tags, article_href_tags)]

print(json.dumps(guardian_articles_data, sort_keys=True, indent=4))

cur.executemany("INSERT INTO guardian VALUES(?, ?, ?)", guardian_articles_data)
con.commit()
con.close()
