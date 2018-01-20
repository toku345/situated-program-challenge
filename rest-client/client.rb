#!/usr/bin/env bundle exec ruby
require 'thor'
require 'faraday'

class RestClient < Thor
  desc 'get <URL>', 'get <サーバURL>'
  def get(url)
    res = Faraday.get(url, content_type: 'application/json')
    puts res.body
  end

  desc 'post <URL> <JSONデータ>', 'post <サーバURL> <JSONデータ>'
  def post(url, params = nil)
    res = Faraday.post(url, params, content_type: 'application/json')
    puts res.body
  end
end

RestClient.start(ARGV)
