require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/articles'
  end

  get '/articles' do
    @all_articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @new_art = Article.create(params)
    #binding.pry
    redirect to "/articles/#{@new_art.id}"
  end

  get '/articles/:id' do
    @art = Article.find_by(id: params[:id])
    # binding.pry
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect to '/articles'
  end

end
