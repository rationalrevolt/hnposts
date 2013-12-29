module Hntrendz

  class Post
    
    attr_accessor :title, :points, :comments, :position

    def initialize( options )
      @title = options[:title] || "No Title"
      @points = options[:points] || 0
      @comments = options[:comments] || 0
      @position = options[:position] || 0
    end

    def to_s
      "#{position}. #{title}, #{points} points #{comments} comments"
    end
    
  end
  
end
