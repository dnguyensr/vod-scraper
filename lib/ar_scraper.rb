require_relative './scrape'

def make_vod_url(url)
  return 'http://www.arirang.com/Player/Vod_Play.asp?MKey=' << url
end

def push_vods_to_db(doc)
  doc.css('.tv_vodlist li').each do |vod|
    vod_id = vod.css('h6').text.to_i
    vod_code = vod.css('a').attr('href').value.match(/'([^"]*)'/)[1]
    vod_cnt = vod.css('.vod_cnt')
    title = vod_cnt.at_css('strong').remove.text
    date = vod_cnt.inner_text
    url = make_vod_url(vod_code)

    create_vod(vod_id, url, title, date)
  end
end

def create_vod(id, url, title, date)
  DB::Queries.create_vod(
    id: id,
    url: url,
    title: title,
    date: date
  )
end

def scrape
  doc = Nokogiri::HTML(open('http://www.arirang.com/Tv2/Tv_VOD_Category.asp?PROG_CODE=TVCR0102&Menu_Code=101824'))
  push_vods_to_db(doc)
end
