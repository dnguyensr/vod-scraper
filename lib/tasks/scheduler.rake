require_relative "../ar_scraper"

desc "Scrape vods"
task :scrape_vods => :environment do
  puts "Scraping vods..."
  scrape
  puts "Scraping complete."
end
