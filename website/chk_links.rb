#!/usr/bin/ruby
# サイトのリンクをチェック
# skyparametric
# http://skyparametric.com/link/
#
require "pp"
require "faraday"
require 'nokogiri'
Encoding.default_internal = "UTF-8"
main_uri = "http://skyparametric.com"

def http_conn(uri)
  return Faraday::Connection.new(:url => uri) do |builder|
    builder.use Faraday::Request::UrlEncoded
    builder.use Faraday::Response::Logger
    builder.use Faraday::Adapter::NetHttp
  end
end

## リンクページから一覧を出す
res = http_conn(main_uri).get "/link/"
html =  res.body
doc = Nokogiri::HTML.parse(html)
links = doc.css('a').to_s.split("</a>")

## サイトのタイトル変更とリンク切れをチェック
links.each do |a_tag|
  next if !a_tag.include?("http")
  next if a_tag.include?("skyparametric")

  puts "#{doc.text} check start....."
  # リンク先チェック
  r = http_conn(url).get "/"
  case r.status.to_S
  when "200"
    puts "Status OK"
		h =  r.body
		doc = Nokogiri::HTML.parse(h)
		puts doc.css('title').to_s
  when "304"
    puts "Status OK"
  when "500"
    puts "Status Internal Server Error"
  when "404"
    puts "Status Page Not Found"
  else
		puts "not found"
  end
end
