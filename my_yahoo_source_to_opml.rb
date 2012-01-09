require 'builder'

class MyYahooSourceToOPML

  # method which generates opml from my yahoo html source input
  def process_html(title, html_src)

    urls = Array.new
    # todo - convert to form input
    #open 'yahoo_financial_source.html' do |file|
      #while line = file.gets
        urls += grep_feed_url(html_src)
    #  end
    #end

    # generate opml
    opml = ''
    gen_opml = Builder::XmlMarkup.new(:target => opml, :indent => 2)
    gen_opml.instruct!
    gen_opml.opml(:version => 1.1) do
      gen_opml.head do
        gen_opml.title title
        gen_opml.dateCreated Time.now
        gen_opml.dateModified Time.now
      end
      gen_opml.body do
        gen_opml.outline(:title => title) do
          urls.each do |url|
            gen_opml.outline({:type => 'rss', :xmlUrl => url})
          end
        end
      end
    end
    return opml
  end

  # parse out feed urls from html source
  # return an array of urls
  def grep_feed_url(line)
    feed_urls = Array.new
    line.scan(/\"feedUrl\":\"(.*?)"/).each { |furl| 
      feed_urls << furl.first.gsub(/\\/,'')
    }
    return feed_urls
  end
end

