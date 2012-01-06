#8bitURL.rb
require 'rubygems'
require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'

### CONTROLLER ACTIONS

layout :layout

#Home Page
get '/' do
  haml :index
end

#Give URL Page
#get '/bonus/:tix' do
#  @biturl = Biturl.first(:tix=>params[:tix])
#  haml :bonus
#end

#Create a URL
#post '/bonus' do
#  url = params[:url] =~ /(^http:\/\/|^https:\/\/)/ ? params[:url] : "http://" + params[:url]
#  @biturl = Biturl.first(:url=>url)
#  if @biturl.nil?
#    tix = Biturl.gen_ticket()
#    @biturl = Biturl.create({:tix=>tix, :url=>url, :created_at=>Time.now})
#  end
#  redirect "/bonus/#{@biturl.tix}"
#end

#Bounce Page
#get '/:tix' do
#  tix = params[:tix]
#  biturl = Biturl.first(:tix=>tix)
#  redirect biturl.nil? ? "/" : biturl.url
#end