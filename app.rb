require 'sinatra/base'
require './lib/bookmark'
require 'sinatra/flash'
require 'uri'
require_relative './database_connection_setup.rb'

database_setup

class Bmm < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/new' do
    erb :new
  end

  post '/add_bookmark' do
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
    Bookmark.create(url: params[:url], title: params[:title])
  else
  flash[:notice] = "You must submit a valid URL."
 end
    redirect '/bookmarks'
  end

  post '/delete_bookmark' do
    Bookmark.delete(params[:delete_title])
    redirect '/'
  end

  post '/update_bookmark' do
    Bookmark.update(params[:old_title], params[:update_title], params[:update_url])
  redirect '/'
  end

end
