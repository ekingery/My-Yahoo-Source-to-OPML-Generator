require 'builder'

# generates opml from my yahoo html source input
class MyYahooSourceToOPML

  # process the input html_src and output opml using input title
  def process_html(title, html_src)

    urls = grep_feed_url(html_src)

    # generate opml
    opml = ''
    gen_opml = Builder::XmlMarkup.new(:target => opml, :indent => 2)
    gen_opml.instruct!
    gen_opml.opml(:version => 1.1) do
      gen_opml.head do
        gen_opml.title title
        gen_opml.dateCreated Time.now
      end
      gen_opml.body do
        gen_opml.outline(:title => title) do
          # loop for each feed url in the input
          urls.each do |url|
            gen_opml.outline({:type => 'rss', :xmlUrl => url})
          end
        end
      end
    end
    return opml
  end

  # parse out feed urls from html source, return an array of feed urls
  def grep_feed_url(line)
    feed_urls = Array.new
    line.scan(/\"feedUrl\":\"(.*?)"/).each { |furl| 
      feed_urls << furl.first.gsub(/\\/,'')
    }
    return feed_urls
  end

end

