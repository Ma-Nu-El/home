# priceFetcher.py
import sys
import argparse
import requests
from bs4 import BeautifulSoup

class PriceFetcher:
    def __init__(self, url, css_selector):
        self.url = url
        self.css_selector = css_selector
        self._price = None

    def fetch_price(self):
        try:
            response = requests.get(self.url)
            response.raise_for_status()
            soup = BeautifulSoup(response.text, 'html.parser')
            price_element = soup.find_all(self.css_selector)

            if price_element:
                self._price = price_element.text.strip()
            else:
                self._price = "Price not found"
        except requests.RequestException as e:
            self._price = "Price not found due to network issue: {}".format(e)

        return self._price

def main():
    parser = argparse.ArgumentParser(description='Fetch a price from a webpage.')
    parser.add_argument('url', type=str, help='URL of the webpage to fetch the price from.')
    parser.add_argument('css_selector', type=str, help='CSS selector for the price element.')
    args = parser.parse_args()

    price_fetcher = PriceFetcher(args.url, args.css_selector)
    price = price_fetcher.fetch_price()
    print(price)

if __name__ == '__main__':
    main()
