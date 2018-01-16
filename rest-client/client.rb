#!/usr/bin/env bundle exec ruby
require 'thor'
require 'faraday'

class RestClient < Thor
  desc 'get http://localhost:3000/person [key1=value1 key2=value2]', 'get サーバURL [パラメタ]'
  def get(url, *args)
    params = convert_to_params(args)
    res = Faraday.get(url, params)
    puts res.body
  end

  desc 'get http://localhost:3000/person key1=value1 key2=value2', 'post サーバURL [パラメタ]'
  def post(url, *args)
    params = convert_to_params(args)
    res = Faraday.post(url, params)
    puts res.body
  end

  private

  def convert_to_params(args)
    Hash[*args.map { |arg| arg.split('=') }.flatten]
  end
end

RestClient.start(ARGV)
