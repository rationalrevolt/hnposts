module Hntrendz

  class Post
    
    attr_accessor :title, :points, :comments

    def initialize( options )
      @title = options[:title] || "No Title"
      @points = options[:points] || 0
      @comments = options[:comments] || 0
    end

    def to_s
      "#{title}, #{points} points #{comments} comments"
    end
    
  end
  
end
