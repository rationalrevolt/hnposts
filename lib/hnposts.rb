require 'open-uri'
require 'nokogiri'
require 'hnposts/version'
require 'hnposts/post'
require 'hnposts/fetcher'

module HNPosts

  def self.fetch_posts
    Fetcher.new.fetch_posts
  end  
  
end
