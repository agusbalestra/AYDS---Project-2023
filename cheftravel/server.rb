require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'bundler/setup'

 
set :database, {adapter: "sqlite3", database: "db.sqlite3"}

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  class User < ActiveRecord::Base
  end 

  get '/' do
    erb :index
  end

  # Crea o encuentra un usurio en la bdd dependiendo del nombre que inserte
  post '/users' do
    @user = User.find_or_create_by(name: params[:name], password: params[:password])
    
    erb :user
  end

  # Lista todos los usuarios registrados en la base de datos
  get '/users' do
    @users = User.all
    
    erb :users
  end

  get '/menu' do

    erb :menu
  end

  get '/question' do

    erb :question
  end


end