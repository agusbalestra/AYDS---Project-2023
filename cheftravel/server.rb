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

class App < Sinatra::Application
  
  enable :sessions
  register Sinatra::Cookies

  def initialize(app = nil)
    super()
  end

  before '/menu' do
    unless current_user.present?
      redirect '/'
    end
  end

  ## 
  get '/' do
    erb :index
  end

  ##
  get '/register' do
    erb :register
  end

  ##REGISTERMENU
  post '/registermenu' do

    user = User.new(params)
    if user.valid?
      user.points = 0
      user.save
      session[:user_id] = user.id
      erb :menu, locals: { user: user }
    else
      erb :fail_register, locals: { msgfail: user.errors.full_messages }
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
    user = current_user
    erb :menu, locals: {user: user}
  end


  get '/arg' do
    user = current_user
    erb :arg, locals: {user: user}
  end


  get '/chile' do
    user = current_user
    erb :chile, locals: {user: user}
  end


  get '/ranking' do
    user = current_user
    usersname = User.select(:name).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb erb :ranking, locals: {usersname: usersname, index: 0, userspoints: userspoints, user: user}
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
      
      if (question.present?)
        if (level.id == question.levels_id)
          answers = Answer.where(question_id: question.id)
          user = current_user
          
          if level.id < 1000
            erb :question, locals: {level: level, question: question, answers: answers, user: user}
          else
            if user.points > 170
              erb :frontera, locals: {level: level, question: question, answers: answers, user: user}
            else
              redirect '/menu'
            end
          end
        else
          redirect '/menu'
        end
      else
        redirect '/menu'
      end

    else # user not logued
      redirect '/'  
    end
  end


  post '/question' do      
    question = Question.find(params[:question_id])
    option_id = params[:option_id].to_i
    
    if option_id == 0 # si el usuario no seleciona una respuesta 
      
      redirect "/level/#{question.levels_id}/question/#{question.id}"
    
    else # si el usuario selecciona una respuesta 

      option = Answer.find(option_id)
      user = current_user
      informed_text = question.informed_text
      correct_answer = question.answers.find_by(correct: true)

      if option.correct
        result_message = "¡CORRECTO!"
        user.sum_points(question)
      else 
        result_message = "INCORRECTO"
        user.rest_points(question)
      end

      erb :result, locals: { result_message: result_message, id_question: question.id , id_level: question.levels_id, user: user, informed_text: informed_text, correct_answer: correct_answer}
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
