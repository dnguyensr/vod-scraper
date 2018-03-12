require_relative "lib/ar_scraper"
require_relative "lib/scrape_yt"

desc "Scrape vods"
task :scrape_vods do
  puts "Scraping vods..."
  scrape
  puts "Scraping complete."
end

desc "Scrape arkpop yt"
task :scrape_arkpop_yt do
  puts "Scraping yt..."
  arkpop_args = {
    url: 'https://www.youtube.com/user/arirangworld/videos',
    contains: 'Pops in Seoul'
  }
  scrape_arkpop_yt(arkpop_args)
  puts "Scraping complete."
end

