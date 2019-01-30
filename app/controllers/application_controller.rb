
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  # => index_page
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # => new_page
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  # => create_page
  post "/articles" do
     @article = Article.create(params)
     redirect to "/articles/#{ @article.id }"
   end


  # =>  show_one_instance
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # => edit_page
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  # => update_page
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  # => DELETE
  delete "/articles/:id" do
    Article.destroy(params[:id])

    redirect to "/articles"
  end
end
