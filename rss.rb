require 'nokogiri'
require 'open-uri'

class Rss

  #### Pod Casts ####
  def self.update_gamebreaker
    doc = Nokogiri::XML(open("http://feeds.feedburner.com/TheRepublic-TheStarWarsTheOldRepublicPodcast?format=xml"))
    newest = doc.xpath('//item').first
    data = {}
    data[:title] = newest.xpath('title').text
    data[:link] = newest.xpath('link').text
    data[:image_url] = newest.xpath('blip:picture').text
    data[:pubdate] = Date.parse(newest.xpath('pubDate').text).to_s rescue nil
    data[:last_update] = (Date.today - Date.parse(newest.xpath('pubDate').text)).to_i rescue nil
    settings.cache.set('gamebreaker', data, 3600)
    data
  end

  def self.update_darthhater_cast
    doc = Nokogiri::XML(open("http://www.darthhater.com/articles/podcast.rss"))
    newest = doc.xpath('//item').first
    data = {}
    data[:title] = newest.xpath('title').text
    data[:link] = newest.xpath('link').text
    data[:image_url] = doc.xpath('//image/url').text
    data[:pubdate] = Date.parse(newest.xpath('pubDate').text).to_s rescue nil
    data[:last_update] = (Date.today - Date.parse(newest.xpath('pubDate').text)).to_i rescue nil
    settings.cache.set('darthhater_cast', data, 3600)
    data
  end

  #### News Feeds ####
  def self.update_darthhater
    settings.cache.set('darthhater', '')
  end

  def self.update_devtracker
    settings.cache.set('devtracker', '')
  end

  def self.update_guild_twitter
    settings.cache.set('guild_twitter', '')
  end

  def self.update_guild_reddit
    settings.cache.set('guild_reddit', '')
  end

  def self.update_swtor_reddit
    settings.cache.set('swtor_reddit', '')
  end

  def self.get_feed(feed)
    data = settings.cache.get(feed)
    data = send("update_#{feed}") if data.nil?
    data
  end

  def self.expire_cache
    settings.cache.flush
  end
end