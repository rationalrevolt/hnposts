module Hntrendz

  class Fetcher    

    HN_URL = "https://news.ycombinator.com/"

    def initialize
      @hn_doc = Nokogiri::HTML(_contents)
    end

    def fetch_posts
      return @posts if @posts
      
      titles, points, comments = _titles, _points, _comments
      post_count = titles.size - 2
      @posts = (0..post_count).collect do | indx |
        Post.new title: titles[indx],
                 points: points[indx],
                 comments: comments[indx],
                 position: (indx + 1)
      end
    end
      
    private

    attr_reader :hn_doc

    def _titles
      hn_doc.css('td[class=title] a').collect { |tag| tag.text.strip }
    end

    def _points
      hn_doc.css('td[class=subtext] span').collect { |tag| tag.text[/\d+/].to_i }
    end

    def _comments
      cntr = 0
      hn_doc.css('td[class=subtext] a').reduce([]) do | acc, tag |
        acc.tap do |acc|
          acc << tag.text[/\d+/].to_i if cntr.odd?
          cntr = cntr.next
        end
      end
    end
    
    def _contents
      open(HN_URL)
    end
    
  end

end
