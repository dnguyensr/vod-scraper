require 'dotenv/load'
require 'rubygems'
require 'bundler'
require_relative 'db'
require_relative 'queries'

Bundler.require

class App < Sinatra::Base
	get '/' do
		erb :index
  end

  get '/vods' do
    @vods =  DB::Queries.all_vods
    erb :vods
  end
end
