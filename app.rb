require 'dotenv/load'
require 'rubygems'
require 'bundler'
require 'sinatra/namespace'
require_relative 'db'
require_relative 'queries'
require_relative 'lib/scrape_yt'
require_relative 'lib/ar_scraper'

Bundler.require

class App < Sinatra::Base
  set :method_override, true
  set :sessions, :expire_after => 21600
  register Sinatra::Namespace

  helpers do
    def is_admin?
      session[:admin] == true
    end
  end

  get '/' do
    @vods =  DB::Queries.all_vods
    @yt =  DB::Queries.get_vods_from_yt
		erb :index, :layout => :template
  end

  get '/admin' do
    redirect '/admin/'
  end


  namespace '/admin' do
    get '/' do
      if is_admin?
        @vods =  DB::Queries.all_vods
        @yt =  DB::Queries.get_vods_from_yt
        erb :admin, :layout => :template
      else
        erb :auth, :layout => :template
      end
    end

    post '/' do
      if params[:admin_pass] == ENV['ADMIN_PASS']
        session[:admin] = true
        redirect '/admin/'
      else
        redirect '/admin/'
      end
    end

    get '/yt' do
      redirect '/admin/yt/'
    end

    namespace '/yt' do
      before do
        redirect '/admin/' if !is_admin?
      end
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
        DB::Queries.delete_yt(id: params[:id])
        redirect '/admin/yt/'
      end
    end

    get '/vods' do
      redirect '/admin/vods/'
    end

    namespace '/vods' do
      before do
        redirect '/admin/' if !is_admin?
      end
      get '/' do
        @vods =  DB::Queries.all_vods
        p Date
        erb :'admin/admin_vod', :layout => :template
      end

      post '/scrape' do
        scrape
        redirect '/admin/vods'
      end

      delete '/delete' do
        DB::Queries.clear_vods
        redirect '/admin/vods'
      end

      get '/:id/edit' do
        @vod =  DB::Queries.find_vods_by_id({id:  params[:id]})[0]
        erb :'admin/admin_vod_edit', :layout => :template
      end

      delete '/:id' do
        DB::Queries.delete_vod(id: params[:id])
        redirect '/admin/vods'
      end
    end
  end
end
