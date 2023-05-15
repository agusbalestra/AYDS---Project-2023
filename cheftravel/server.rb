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

  get '/register' do
    erb :register
  end

  post '/registermenu' do
    @@user = User.create(name: params[:name], password: params[:password], 
                         firstname: params[:firstname], lastname: params[:lastname],
                         email: params[:email], points: 0)

    erb :argentina
  end


  post '/logmenu' do
    @@user = User.find_by(name: params[:name], password: params[:password])
    
    erb :argentina
  end
  
  get '/menu' do

    erb :argentina
  end

  get '/ranking' do
    @@usersname = User.select(:name).order(points: :desc)
    @@userspoints = User.select(:points).order(points: :desc)
    @@n = 0

    erb :ranking
  end

  get '/question/:id' do
    @@question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: @@question.id)

    
    erb :question
  end

  post '/question' do

    option_id = params[:option_id].to_i
    option = Answer.find(option_id)

    if option.correct
      result_message = "¡CORRECTO!"
      if @@question.difficulty.to_i == 1
        @@user.update(points: @@user.points.to_i+10)
      else
        if @@question.difficulty.to_i == 2
          @@user.update(points: @@user.points.to_i+20)
        else
          @@user.update(points: @@user.points.to_i+30)
        end
      end

    else
      result_message = "INCORRECTO"
      if @@question.difficulty.to_i == 1
        @@user.update(points: @@user.points.to_i-10)
      else
        if @@question.difficulty.to_i == 2
          @@user.update(points: @@user.points.to_i-20)
        else
          @@user.update(points: @@user.points.to_i-30)
        end
  
      end
    end
  
    erb :result, locals: { result_message: result_message, id: @@question.id }
  end

end