require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/cookies'
require 'bundler/setup'

require_relative 'models/question'
require_relative 'models/user'
require_relative 'models/answer'
require_relative 'models/level'
require_relative 'models/recipe'


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
    name = params[:name]
    password = params[:password]
    firstname = params[:firstname]
    lastname = params[:lastname]
    email = params[:email]
    reppw = params[:reppw]

    user_exists = User.find_by(name: name)

    if reppw != password

      msgfail = "Las contraseñas no coinciden"
      
      erb :fail_register, locals: {msgfail: msgfail}
    elsif password.length < 6

      msgfail = "Su contraseña es muy corta. El mínimo es de 6 caracteres"

      erb :fail_register, locals: {msgfail: msgfail}
    elsif user_exists != nil

      msgfail = "Ya existe un usuario con ese nombre de usuario. Por favor, elige otro"

      erb :fail_register, locals: {msgfail: msgfail}
    else
      user = User.create(name: name, password: password,
                         firstname: firstname, lastname: lastname,
                         email: email, points: 0)
      session[:user_id] = user.id

      erb :menu, locals: {user: user}
    end
  end

  ## LOGMENU
  post '/logmenu' do
    user = User.find_by(name: params[:name], password: params[:password])

    if user
      session[:user_id] = user.id
      redirect '/menu'
    else
      msg = "Usuario y/o contraseña incorrectos. Inténtalo nuevamente"
      erb :fail_login, locals: {msg: msg}
    end
  end

  get '/menu' do
    if current_user.present?
      user = current_user
      
      erb :menu, locals: {user: user}
    else
      redirect '/'  
    end
  end

  get '/ranking' do
    usersname = User.select(:name).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb :ranking, locals: {usersname: usersname, index: 0, userspoints: userspoints}
  end

  get '/level/:id_level' do
    level = Level.find_by(id: params[:id_level])
    questions_level = Question.where(levels_id: level.id)
    question = questions_level.first

    redirect "/level/#{params[:id_level]}/question/#{question.id}"
  end

  get '/level/:id_level/question/:id_question' do
    if current_user.present?
      level = Level.find_by(id: params[:id_level])
      question = Question.find_by(id: params[:id_question])
      
      #
      if level.id == question.levels_id
        answers = Answer.where(question_id: question.id)
        user = current_user
        
        erb :question, locals: {level: level, question: question, answers: answers, user: user}
      else
        redirect '/menu'
      end

    else # else si no encuentra usuario
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
        question = Question.find(params[:question_id])
        user = current_user
        informed_text = question.informed_text
        correct_answer = question.answers.find_by(correct: true)

        if option.correct
          result_message = "¡CORRECTO!"
          if question.difficulty.to_i == 1
            user.update(points: user.points.to_i + 10)
          elsif question.difficulty.to_i == 2
            user.update(points: user.points.to_i + 20)
          else
            user.update(points: user.points.to_i + 30)
          end
        else 
          result_message = "INCORRECTO"
          if question.difficulty.to_i == 1
            user.update(points: user.points.to_i - 10)
          elsif question.difficulty.to_i == 2
            user.update(points: user.points.to_i - 20)
          else
            user.update(points: user.points.to_i - 30)
          end
        end

        erb :result, locals: { result_message: result_message, id_question: question.id , id_level: question.levels_id, user: user, informed_text: informed_text, correct_answer: correct_answer}
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
