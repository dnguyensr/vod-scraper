require 'pg'
require_relative 'queries'

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

    conn = PG::Connection.new(ENV['DATABASE_URL'])

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
