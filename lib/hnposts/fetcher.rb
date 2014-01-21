module HNPosts

  class Fetcher    

    HN_URL = "https://news.ycombinator.com/"

    def fetch_posts
      posts = []
      post_nodes = Nokogiri::HTML(contents).css('td[class=title]:nth-of-type(3)').map {|n| n.parent}

      post_nodes.each_with_index do | node, indx |
        posts << Post.new({
                           post_id: (post_id node),
                           title: (title node),
                           url: (url node),
                           points: (points node),
                           comments: (comments node),
                           position: (indx + 1)
                         })
      end

      posts
    end
      
    private

    def post_id tr
      vote_node = tr.css('td > center > a')[0]
      title_node = tr.css('td[class=title] > a')[0]
      if vote_node
        /^up_(\d+)$/.match(vote_node.attributes['id'])[1]
      else
        /^item\?id=(\d+)$/.match(title_node.attributes['href'])[1]
      end.to_i
    rescue
      nil
    end
    
    def title tr
      tr.css('td[class=title] > a')[0].text.strip
    end

    def url tr
      href = tr.css('td[class=title] > a')[0].attributes['href'].value
      /^item\?id=\d+$/ =~ href ? HN_URL + href : href
    end

    def points tr
      result = tr.next_sibling.css('span')[0]
      result &&= /^(\d+) points$/.match(result.text)
      result &&= result[1]
      result.to_i
    end

    def comments tr
      result = tr.next_sibling.css('a')[1]
      result &&= /^(\d+) comments$/.match(result.text)
      result &&= result[1]
      result.to_i
    end
    
    def contents
      open(HN_URL)
    end

  end

end
