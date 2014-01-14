module HNPosts

  class Post
    
    attr_accessor :title, :points, :comments, :position, :url

    def initialize( options )
      @title = options[:title] || "No Title"
      @url = options[:url] || "http://unknown/url"
      @points = options[:points] || 0
      @comments = options[:comments] || 0
      @position = options[:position] || 0
    end

    def to_s
      "#{position}. #{title}, #{points} points #{comments} comments, #{url}"
    end
    
  end
  
end
