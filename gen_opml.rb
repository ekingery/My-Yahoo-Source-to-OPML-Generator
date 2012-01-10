require 'sinatra'
require './my_yahoo_source_to_opml'

$max_title_len = 50

# setup html escaping from rack
helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/' do
  erb :index
end

post '/' do
  # replace all non alphanumeric title characters with underscores
  title = params[:post]['title'].gsub(/[^[:alnum:]]/, '_')[0..$max_title_len]

  # convert the text box contents into corresponding opml
  opml = MyYahooSourceToOPML.new.process_html title, params[:post]['htmlsrc']

  # output the requested format
  if 'download' == params[:post]['view_type']
    response.headers['content_type'] = "application/octet-stream"
    filename = title.empty? ? 'untitled' : title
    attachment(filename + '.xml')
    response.write(opml)
  else
    @opml_src = opml
    erb :posted
  end

end

