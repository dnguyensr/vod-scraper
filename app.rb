require 'dotenv/load'
require 'rubygems'
require 'bundler'

Bundler.require

class App < Sinatra::Base
	get '/' do
		return 'hello world'
	end
end