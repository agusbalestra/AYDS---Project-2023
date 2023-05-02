require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'

 
set :database, {adapter: "sqlite3", database: "db.sqlite3"}

class User < ActiveRecord::Base
end

get '/' do
  erb :index
end

post '/users' do
  @user = User.find_or_create_by(name: params[:name])

  erb :user
end

# Lista todos los usuarios registrados en la base de datos
get '/users' do
  @users = User.all

  erb :users
end