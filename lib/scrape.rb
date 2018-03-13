require 'nokogiri'
require 'open-uri'
require 'date'
require_relative '../db'
require_relative '../queries'
require 'dotenv/load'

def open_url_html(url)
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  doc = Nokogiri::HTML(open(url, 'User-Agent' => user_agent))
end

def open_url_xml(url)
  user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"
  doc = Nokogiri::XML(open(url, 'User-Agent' => user_agent))
end


def push_vod_to_yt(id, url, title, date)
  DB::Queries.push_vod_to_yt(
    id: id,
    url: url,
    title: title,
    date: date
  )
end

# WIP: table_name is a string and is invalid for query SELECT id from 'table_name'
def get_ids_from(table_name)
  DB::Queries.get_ids_from(table: table_name)
end
