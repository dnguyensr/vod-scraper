require 'dotenv/load'
require 'rubygems'
require 'bundler'
require_relative 'db'
require_relative 'queries'
require_relative 'lib/ar_scraper'

Bundler.require

class App < Sinatra::Base
  set :method_override, true

  get '/' do
    @vods =  DB::Queries.all_vods
		erb :index, :layout => :template
  end

  get '/vods' do
    @vods =  DB::Queries.all_vods
    erb :vods, :layout => :template
  end

  delete '/vods/:id' do
    DB::Queries.delete_vod(id: params[:id])
    redirect '/vods'
  end

  post '/scrape_vods' do
    scrape
    redirect '/vods'
  end

  delete '/vods' do
    DB::Queries.clear_vods
    redirect '/vods'
  end
end
