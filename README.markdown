My Yahoo Source to OPML Generator
=================================

Converts My Yahoo Source code to OPML for importing into other web services
---------------------------------------------------------------------------

http://gen-opml.ekingery.com/

### Why?
At the time of writing, Yahoo does not allow you to export your My Yahoo RSS feeds. This OPML Generator allows you to export your feeds in OPML format, which can be consumed by google reader and many other feed reading services. More information can be found on a [related stack exchange post](http://webapps.stackexchange.com/questions/1694/how-can-i-export-my-rss-feeds-from-my-yahoo/21856#21856).

### Deploy
This app is designed for deployment on heroku using the cedar stack. With a
valid git clone and heroku account setup, deployment should be as simple as: 

	heroku create --stack cedar
	git push heroku master

### Todo
Get [google](http://support.google.com/reader/bin/answer.py?hl=en&answer=70572)
 and [netvibes](http://faq.netvibes.com/how_to_switch_from_my_old_service_to_netvibes#switch_from_my_yahoo_to_netvibes) to update their FAQs.

