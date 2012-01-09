require 'sinatra'
require './my_yahoo_source_to_opml'

$max_title_len = 50

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

  opml = MyYahooSourceToOPML.new.process_html title, params[:post]['htmlsrc']

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

__END__
@@ layout

<html>
<head> <title>My Yahoo HTML Source -> OPML Generator</title> </head>
<body>
<h2><a href="/">My Yahoo HTML Source -> OPML Generator</a></h2>
<%= yield %>
</body>
</html>

@@ index
<form action="" method="post">
Import Label: 
  <input type="text" name="post[title]" maxlength="<%= $max_title_len %>"/>
  (optional)
<br /><br />Paste My Yahoo HTML Source Here:<br />
<textarea name="post[htmlsrc]" rows="20" cols="80"></textarea><br />
<input type="radio" name="post[view_type]" value="view" checked/>
View OPML Source
<input type="radio" name="post[view_type]" value="download"/>Download OPML File 
<br /> <input type="submit" value="Generate" />
</form>

@@ posted
<pre><%= h @opml_src %></pre>
