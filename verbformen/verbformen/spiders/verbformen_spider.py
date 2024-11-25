import re
import scrapy

CLEANR = re.compile('<.*?>') # https://stackoverflow.com/a/12982689

class VerbformenSpider(scrapy.Spider):
    name = "verbformen"

    def start_requests(self):
        yield scrapy.Request(url="https://www.verbformen.com/search/?w=", callback=self.parse)

    def parse(self, response):
        for entry in response.css("div.rU6px.rO0px"):
            yield {
                "word":  re.sub(CLEANR, '', entry.css("div span q").get()),
            }