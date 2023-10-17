# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/cookies'
require 'bundler/setup'
require 'sinatra/flash'
require 'bcrypt'
require 'omniauth'
require 'omniauth-google-oauth2'
require 'json'
require 'jwt'

require_relative 'models/question'
require_relative 'models/user'
require_relative 'models/answer'
require_relative 'models/level'
require_relative 'models/recipe'
require_relative 'models/correct_questions'

# Server for app
class App < Sinatra::Application
  enable :sessions
  register Sinatra::Cookies
  use OmniAuth::Builder do
    provider :google_oauth2, '832010478415-ugp0o039v71f8kv1334rckru6tegj2qa.apps.googleusercontent.com', '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'
  end

  def initialize(app = nil)
    super()
  end

  before ['/menu', '/arg', '/chile', '/ranking', '/level', '/question', '/correct', '/incorrect', '/profile', '/update_profile'] do
    redirect '/' unless current_user.present?
  end

  # root page
  get '/' do
    erb :index
  end

  # Routes for Google authentication
  post '/auth/google_callback' do
    auth_response = request.body.read

    credential_start = auth_response.index('credential=')
    if credential_start
      credential_start += 'credential='.length
      jwt = auth_response[credential_start..-1]
    else
      return 'Error: No se encontró el token de autenticación.'
    end

    begin
      decoded_token = JWT.decode(jwt, nil, false)
    rescue JWT::DecodeError
      return 'Error: El token no es válido.'
    end

    user_id = decoded_token[0]['sub']
    name = decoded_token[0]['name']
    email = decoded_token[0]['email']

    user = User.find_by(email: email)
    if user       # El usuario ya existe, se inicia sesión
      session[:user_id] = user.id

    else       # Registro de usuario nuevo
      begin
        user = User.new(name: name, email: email)
        user.auth_with_google = true  # skips validates
        user.save
        session[:user_id] = user.id
      rescue => e
        puts "Error al crear el usuario: #{e.message}"
        puts e.backtrace
      end
    end

    redirect '/menu'

  end

  # REGISTERMENU
  get '/register' do
    erb :register
  end

  post '/registermenu' do
    user = User.new(params)

    if user.valid?

      user.save
      session[:user_id] = user.id
      erb :menu, locals: { user: user }

    else
      erb :fail_register, locals: { msgfail: user.errors.full_messages }
    end
  end

  # LOGMENU
  post '/logmenu' do
    user = User.find_by(name: params[:name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/menu'
    else
      msg = 'Usuario y/o contraseña incorrectos. Inténtalo nuevamente'
      erb :fail_login, locals: { msg: msg }
    end
  end

  get '/menu' do
    user = current_user
    erb :menu, locals: { user: user }
  end

  get '/arg' do
    user = current_user
    erb :arg, locals: { user: user }
  end

  get '/chile' do
    user = current_user
    erb :chile, locals: { user: user }
  end

  get '/ranking' do
    user = current_user
    usersname = User.select(:name, :points).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb erb :ranking, locals: { usersname: usersname, index: 0, userspoints: userspoints, user: user }
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
            if user.current_level >= 3
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

    if params[:timeout] == 'true'
      redirect "/level/#{question.levels_id}/question/#{question.id+1}"

    elsif option_id == 0 # si el usuario no seleciona una respuesta

      redirect "/level/#{question.levels_id}/question/#{question.id}"

    else # si el usuario selecciona una respuesta

      selected_option = Answer.find(option_id)
      user = current_user

      unless CorrectQuestions.exists?(question_id: question.id, user_id: user.id) # para que no sume puntos si ya contesto esa pregunta
        CorrectQuestions.create(question_id: question.id, user_id: user.id)
        user.points_treatment(selected_option.correct, question.difficulty)
      end

      selected_option.correct ? correct = "correct" : correct = "incorrect"
      redirect "/#{correct}?question=#{question.id}"
    end
  end

  get '/correct' do
    question_id = params[:question]

    question = Question.find(question_id)

    erb :result, locals: { result_message: '¡CORRECTO!',
                           user: current_user,
                           id_question: question.id,
                           id_level: question.levels_id,
                           informed_text: question.informed_text }
  end

  get '/incorrect' do
    question_id = params[:question]

    question = Question.find(question_id)

    erb :result, locals: { result_message: '¡INCORRECTO!',
                           id_question: question.id,
                           id_level: question.levels_id,
                           user: current_user,
                           informed_text: question.informed_text,
                           correct_answer: question.answers.find_by(correct: true) }
  end

  get '/logout' do
    session.clear   # Elimina todos los datos de la sesión
    redirect '/'    # Redirige al usuario a la página de inicio
  end

  get '/recipe-book' do
    max_lv = current_user.current_level
    levels = []

    if(max_lv != 0)
      for i in(1..max_lv)
        lv = Level.find(i)
        levels << lv
      end
    end

    erb :recipebook, locals: {user: current_user,  levels: levels}
  end

  get '/recipe-book/:id_level' do

    lv = Level.find( params[:id_level])


    erb :recipe, locals: {level: lv, user: current_user}
  end


  ## PROFILE
  get '/profile' do
    user = current_user
    total_questions = Question.count
    # TODO: Implementar el cálculo del número de preguntas respondidas por el usuario
    answered_questions = 1
    progress = (answered_questions.to_f / total_questions * 100).round(2)

    erb :profile, locals: { user: user, progress: progress }
  end

  get '/update_profile' do
    erb :update_profile, locals: { user: current_user, errors: [] }
  end

  post '/update_profile' do
    user = current_user
    new_username = params[:name]
    current_pass = params[:current_password]
    new_password = params[:password]
    new_pass_confirm = params[:password_confirmation]
    new_email = params[:email]

    if new_username != '' && User.find_by(name: new_username)
      flash[:error] = 'Name is not valid.'
    elsif new_password != '' && current_pass.nil?
      flash[:error] = 'Please provide your current password.'
    elsif new_password != new_pass_confirm
      flash[:error] = 'New password and confirmation do not match.'
    elsif new_email != '' && User.find_by(email: new_email)
      flash[:error] = 'Email is not valid.'
    else
      user.name = new_username if new_username != ''
      user.password = new_password if new_password != '' && current_pass != ''
      user.email = new_email if new_email != ''

      redirect '/profile' if user.save
    end

    erb :update_profile, locals: { user: current_user }
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
