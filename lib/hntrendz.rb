require 'open-uri'
require 'nokogiri'
require 'hntrendz/version'
require 'hntrendz/post'
require 'hntrendz/fetcher'

module Hntrendz

  def self.fetch_posts
    Fetcher.new.fetch_posts
  end  
  
end
