require 'dotenv/load'
require 'rubygems'
require 'bundler'
require "sinatra/namespace"
require_relative 'db'
require_relative 'queries'
require_relative 'lib/scrape_yt'
require_relative 'lib/ar_scraper'

Bundler.require

class App < Sinatra::Base
  set :method_override, true
  register Sinatra::Namespace

  get '/' do
    @vods =  DB::Queries.all_vods
		erb :index, :layout => :template
  end

  get '/vods' do
    @vods =  DB::Queries.all_vods
    erb :vods, :layout => :template
  end

  get '/yt' do
    @vods =  DB::Queries.get_vods_from_yt
    erb :yt, :layout => :template
  end

  namespace '/admin' do
    get '/yt' do
      redirect '/admin/yt/'
    end
    namespace '/yt' do
      get '/' do
        @vods =  DB::Queries.get_vods_from_yt
        erb :'admin/admin_yt', :layout => :template
      end

      post '/scrape' do
        arkpop_args = {
          url: 'https://www.youtube.com/user/arirangworld/videos',
          contains: 'Pops in Seoul'
        }
        scrape_arkpop_yt(arkpop_args)
        redirect '/admin/yt/'
      end

      delete '/delete' do
        DB::Queries.clear_yt
        redirect '/admin/yt/'
      end

      get '/:id/edit' do
        @vod =  DB::Queries.find_yt_by_id({id:  params[:id]})[0]
        erb :'admin/admin_yt_edit', :layout => :template
      end

      delete '/:id' do
        DB::Queries.delete_vod(id: params[:id])
        redirect '/admin/yt/'
      end
    end
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
