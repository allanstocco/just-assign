import requests
import pandas as pd
import threading


def setInterval(func, time):
    e = threading.Event()
    while not e.wait(time):
        func()


def callapi():
    import json
    
    url = "https://osome-public.p.rapidapi.com/user-post-count"

    querystring = {"start": "2020-01-01T00:00:00",
                   "end": "2020-01-01T23:59:59", "q": "#yolo,#swag"}
    headers = {
        "X-RapidAPI-Key": "9007d1393emsh7ca695b6409e747p10f840jsnac2001b6c83b",
        "X-RapidAPI-Host": "osome-public.p.rapidapi.com"
    }
    response = requests.request(
        "GET", url, headers=headers, params=querystring)

    to_file = json.loads(response.text)

    json = pd.DataFrame(
        [{"JOB_ID": to_file['job_id'], "RESULTS": to_file['result_url']}], index=[0])

    json.to_csv("osome.csv", index=False, sep="\t")


setInterval(callapi, 2)
