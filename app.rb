require 'sinatra/base'
require './lib/bookmark'

class Bmm < Sinatra::Base

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
    Bookmark.create(url: params[:url], title: params[:title])
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
