#! /usr/bin/env python3

import sys
import logging
from requests import Session
from requests.adapters import Retry, HTTPAdapter
from http import HTTPStatus

SERVICES_URL = [
    "https://www.osnews.com",
    "http://httpstat.us/200",
]
RETRIES = 5
TIMEOUT = 10
LOG_LEVEL = logging.DEBUG

def check_service_status(service_url):
    print(f"[ * ] Checking {service_url} for 200 status code...")
    response = None
    try:
        response = session.get(url=service_url, timeout=TIMEOUT)
    except Exception as error:
        logging.error(error)
    finally:
        return response

if __name__ == "__main__":
    logging.basicConfig(
        level=LOG_LEVEL,
        format='%(asctime)s %(levelname)-8s %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S'
    )
    session = Session()
    retries = Retry(
        total=RETRIES, 
        backoff_factor=1, 
        status_forcelist=[502, 503, 504]
    )
    session.mount("http://", HTTPAdapter(max_retries=retries))
    
    for service_url in SERVICES_URL:
        service_response = check_service_status(service_url)

        if service_response is not None and service_response.status_code != HTTPStatus.OK:
            logging.error(f"Got status code {service_response.status_code}")
        
        if service_response is None or service_response.status_code != HTTPStatus.OK:
            sys.exit(1)
        else:
            print(">>>>> Ok")

    print("Grand!")