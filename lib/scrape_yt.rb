require_relative './scrape'

def make_yt_url(url)
  return 'https://www.youtube.com' << url
end

def get_ids_from_yt
  DB::Queries.get_ids_from_yt
end

def scrape_arkpop_yt(args)

  doc = open_url_html(args[:url])
  unique_ids = get_ids_from_yt

  doc.css("a:contains('#{args[:contains]}')").each do |vod|
    if !vod.parent.parent.css('li')[1].text.include?('hour')
      id = vod['href'][9..-1]
      if !unique_ids.include?(id)
        yt_url = make_yt_url(vod['href'])
        title =  vod.text
        date = DateTime.now.strftime('%Y-%m-%d')
        push_vod_to_yt(id, yt_url, title, date)
      end
    end
  end
end
