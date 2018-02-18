require 'pg'
require_relative 'queries'
# Be sure to create db by running `createdb sinatra-scraper`
# or update db name to match the name of db

# conn.exec(%{insert into vods(id, url, title, date) values (4241,'http://www.arirang.com/Player/Vod_Play.asp?MKey=L03UGJGY', '[Pops in Seoul] MOMOLAND(모모랜드)''s Pick & Talk(뽑고 말해요)', '2018-01-31')})

module DB
  class Record
    def initialize(attrs)
      @attrs = attrs
    end

    def method_missing(name)
      @attrs.fetch(name.to_s)
    end
  end


  def self.query(sql_spec, args_hash)
    arg_keys = args_hash.keys
    arg_values = args_hash.values

    conn = PG::Connection.open(:dbname => 'sinatra-scraper')

    sql = sql_spec.gsub(/:\w+/) do |field_name|
      field_name = field_name.to_s.sub(/\A:/, '').to_sym
      "$#{arg_keys.index(field_name) + 1}"
    end

    result = conn.exec(sql, arg_values)
    result_keys = result.fields
    result.values.map do |result_values|
       Record.new(result_keys.zip(result_values).to_h)
    end
  end

  module Queries
    def self.method_missing(id, args_hash={})
      sql = QUERIES.fetch(id)
      DB.query(sql, args_hash)
    end
  end

end
