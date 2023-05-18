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

    @name = params[:name]
    @password =  params[:password]
    @firstname = params[:firstname]
    @lastname = params[:lastname]
    @email = params[:email]
    @reppw = params[:reppw]

    userexists = User.find_by(name: @name)

    if @reppw!=@password
      @msgfail = "Las contraseñas no coinciden"
      erb :fail_register

    else if @password.length < 6
      @msgfail = "Su contraseña es muy corta. El minimo es de 6 caracteres"
      erb :fail_register

    else if userexists != nil
      @msgfail = "Ya existe un usuario con ese username. Por favor escoje otro"
      erb :fail_register

    else
      @@user = User.create(name: @name, password: @password, 
        firstname: @firstname, lastname: @lastname,
        email: @email, points: 0)

      erb :argentina
    end
    end
    end
  end


  post '/logmenu' do
    @@user = User.find_by(name: params[:name], password: params[:password])
    
    erb :argentina

    rescue Exception
      @msg = "Usuario y/o contraseña incorrectos. Intentalo nuevamente"
      
      erb :fail_login
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

    rescue Exception
      @msg = 'Felicidades! te pasaste ChefTravel, por ahora...'
      erb :nomorequest
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