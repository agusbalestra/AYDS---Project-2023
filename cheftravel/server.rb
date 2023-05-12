require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'bundler/setup'
require_relative 'models/question' 
require_relative 'models/user' 
require_relative 'models/answer' 

 
set :database, {adapter: "sqlite3", database: "db.sqlite3"}

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end


  get '/' do
    erb :index
  end


  post '/menu' do
    @user = User.find_or_create_by(name: params[:name], password: params[:password])
    
    erb :menu
  end

  get '/question/:id' do
    @question = Question.find_by(id: params[:id])
    @users = User.last
    erb :question
  end

  post '/question' do
    #user
    #question
    #option
  end


end