require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/cookies'
require 'bundler/setup'

require_relative 'models/question'
require_relative 'models/user'
require_relative 'models/answer'

set :database, { adapter: "sqlite3", database: "db.sqlite3" }

class App < Sinatra::Application
  
  enable :sessions
  register Sinatra::Cookies

  def initialize(app = nil)
    super()
  end

  ## 
  get '/' do
    erb :index
  end

  ##
  get '/register' do
    erb :register
  end

  ##REGISTER MENU
  post '/registermenu' do
    @name = params[:name]
    @password = params[:password]
    @firstname = params[:firstname]
    @lastname = params[:lastname]
    @email = params[:email]
    @reppw = params[:reppw]

    user_exists = User.find_by(name: @name)

    if @reppw != @password

      @msgfail = "Las contraseñas no coinciden"
      
      erb :fail_register
    elsif @password.length < 6

      @msgfail = "Su contraseña es muy corta. El mínimo es de 6 caracteres"

      erb :fail_register
    elsif user_exists != nil

      @msgfail = "Ya existe un usuario con ese nombre de usuario. Por favor, elige otro"

      erb :fail_register
    else
      user = User.create(name: @name, password: @password,
                         firstname: @firstname, lastname: @lastname,
                         email: @email, points: 0)
      session[:user_id] = user.id

      erb :menu
    end
  end

  ## LOGMENU
  post '/logmenu' do
    @user = User.find_by(name: params[:name], password: params[:password])

    if @user
      session[:user_id] = @user.id
      redirect '/menu'
    else
      @msg = "Usuario y/o contraseña incorrectos. Inténtalo nuevamente"
      erb :fail_login
    end
  end

  get '/menu' do
    if current_user
      @user = current_user
      erb :menu
    else
      redirect '/'  
    end
  end

  get '/ranking' do
    @usersname = User.select(:name).order(points: :desc)
    @userspoints = User.select(:points).order(points: :desc)
    @n = 0

    erb :ranking
  end

  get '/question/:id' do
    if current_user.present?
      @question = Question.find_by(id: params[:id])
      if @question.present?
        @answers = Answer.where(question_id: @question&.id)
        @user = current_user
        erb :question
      else
        @msg = "Felicidades, te pasaste ChefTavel, por ahora..."
        @user = current_user
        erb :nomorequest
      end
    else
      redirect '/'
    end
  end

  post '/question' do
    if current_user.present?
      
      option_id = params[:option_id].to_i
      
      if option_id == 0 # si el usuario no seleciona una respuesta 
        
        redirect "/question/#{params[:question_id]}"
      
      else # si el usuario selecciona una respuesta 

        option = Answer.find(option_id)
        @question = Question.find(params[:question_id])
        @user = current_user

        if option.correct
          result_message = "¡CORRECTO!"
          if @question.difficulty.to_i == 1
            @user.update(points: @user.points.to_i + 10)
          elsif @question.difficulty.to_i == 2
            @user.update(points: @user.points.to_i + 20)
          else
            @user.update(points: @user.points.to_i + 30)
          end
        else 
          result_message = "INCORRECTO"
          if @question.difficulty.to_i == 1
            @user.update(points: @user.points.to_i - 10)
          elsif @question.difficulty.to_i == 2
            @user.update(points: @user.points.to_i - 20)
          else
            @user.update(points: @user.points.to_i - 30)
          end
        end

        erb :result, locals: { result_message: result_message, id: @question.id }
      end

    else # else de si el usuario no está logueado
      redirect '/'
    end
    
  end

  get '/logout' do
    session.clear   # Elimina todos los datos de la sesión
    redirect '/'    # Redirige al usuario a la página de inicio
  end

  ## PROFILE
  get '/profile' do
    if current_user.present?
      
      
      erb :profile
    else
      redirect '/'
    end
  end

  post '/profile' do
    
  end

  ## METHODS
  def current_user
    User.find_by(id: session[:user_id])
  end
  
end
