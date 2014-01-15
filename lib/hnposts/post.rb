module HNPosts

  class Post
    
    attr_reader :post_id, :title, :url, :points, :comments, :position

    def initialize( options )
      @post_id = options[:post_id]
      @title = options[:title]
      @url = options[:url]
      @points = options[:points]
      @comments = options[:comments]
      @position = options[:position]
    end

    def to_s
      "#{post_id} - position #{position}, #{title}, #{points} points #{comments} comments, #{url}"
    end
    
  end
  
end
