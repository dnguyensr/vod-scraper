require 'nokogiri'
require 'open-uri'


def make_vod_url(url)
  return 'http://www.arirang.com/Player/Vod_Play.asp?MKey=' << url
end

def scrape(arr)
  doc = Nokogiri::HTML(open('http://www.arirang.com/Tv2/Tv_VOD_Category.asp?PROG_CODE=TVCR0102&Menu_Code=101824'))
  doc.css('.tv_vodlist li').each do |vod|
    vod_code = vod.css('h6').text.to_i
    vod_id = vod.css('a').attr('href').value.match(/'([^"]*)'/)[1]
    vod_cnt = vod.css('.vod_cnt')
    title = vod_cnt.at_css('strong').remove.text
    date = vod_cnt.inner_text
    arr << [vod_code, make_vod_url(vod_id), title, date]
  end
end

arr = []
scrape(arr)
p arr
