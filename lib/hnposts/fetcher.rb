module HNPosts

  class Fetcher    

    HN_URL = "https://news.ycombinator.com/"

    def initialize
      @hn_doc = Nokogiri::HTML(_contents)
    end

    def fetch_posts
      return @posts if @posts
      
      post_ids, titles, urls, points, comments = _post_ids, _titles, _urls, _points, _comments
      post_count = post_ids.size
      @posts = (0...post_count).collect do | indx |
        Post.new post_id: post_ids[indx],
                 title: titles[indx],
                 url: urls[indx],
                 points: points[indx],
                 comments: comments[indx],
                 position: (indx + 1)
      end
    end
      
    private

    attr_reader :hn_doc

    def _post_ids
      hn_doc.css('td > center > a').collect { |tag| /up_(\d+)/.match(tag.attributes['id'].value)[1] }
    end
    
    def _titles
      hn_doc.css('td[class=title] a').collect { |tag| tag.text.strip }
    end

    def _urls
      hn_doc.css('td[class=title] a').collect { |tag| tag.attributes['href'].value }
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
