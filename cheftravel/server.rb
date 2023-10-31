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

require_relative 'models/init'
require_relative 'controllers/init'

# Server for app
class App < Sinatra::Application
  use UserController
  use OmniAuth::Builder do
    provider :google_oauth2, '832010478415-ugp0o039v71f8kv1334rckru6tegj2qa.apps.googleusercontent.com',
             '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'
  end

  enable :sessions
  register Sinatra::Cookies

  def initialize(_app = nil)
    super()
  end

  before ['/menu', '/arg', '/chile', '/ranking', '/level', '/question', '/correct', '/incorrect', '/profile',
          '/update_profile'] do
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

    return 'Error: No authentication token found.' if credential_start.nil?

    jwt = auth_response[(credential_start + 'credential='.length)..]
    begin
      decoded_token = JWT.decode(jwt, nil, false)

      # user_id = decoded_token[0]['sub']
      name = decoded_token[0]['name']
      email = decoded_token[0]['email']

      user = User.find_by(email: email)

      unless user.present?
        user = User.new(name: name, email: email, password: SecureRandom.hex(10))
        user.auth_with_google = true # Skip certain validations

        return "Error: Unable to create a new user. #{user.errors.full_messages.join(', ')}" unless user.save
      end

      session[:user_id] = user.id
      redirect '/menu'
    rescue JWT::DecodeError
      return 'Error: Invalid token.'
    rescue StandardError => e
      return "Error: #{e.message}"
    end
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
    level = Level.find_by(id: params[:id_level])
    question = Question.find_by(id: params[:id_question])

    if question.present?
      if level.id == question.levels_id
        answers = Answer.where(question_id: question.id)
        user = current_user

        if level.id < 1000
          erb :question, locals: { level: level, question: question, answers: answers, user: user }
        elsif user.current_level >= 3
          erb :frontera, locals: { level: level, question: question, answers: answers, user: user }
        else
          redirect '/menu'
        end
      else
        redirect '/menu'
      end
    else
      redirect '/menu'
    end
  end

  post '/question' do
    question = Question.find(params[:question_id])
    option_id = params[:option_id].to_i

    if params[:timeout] == 'true'
      redirect "/level/#{question.levels_id}/question/#{question.id + 1}"

    elsif option_id.zero? # si el usuario no seleciona una respuesta

      redirect "/level/#{question.levels_id}/question/#{question.id}"

    else # si el usuario selecciona una respuesta

      selected_option = Answer.find(option_id)
      user = current_user

      # Para que no sume puntos si ya contesto esa pregunta
      unless CorrectQuestions.exists?(question_id: question.id, user_id: user.id)
        CorrectQuestions.create(question_id: question.id, user_id: user.id)
        user.points_treatment(selected_option.correct, question.difficulty)
      end

      correct = selected_option.correct ? 'correct' : 'incorrect'
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

    if max_lv != 0
      (1..max_lv).each do |i|
        lv = Level.find(i)
        levels << lv
      end
    end

    erb :recipebook, locals: { user: current_user, levels: levels }
  end

  get '/recipe-book/:id_level' do
    lv = Level.find(params[:id_level])

    erb :recipe, locals: { level: lv, user: current_user }
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
      user.password_digest = new_password if new_password != '' && current_pass != ''
      user.email = new_email if new_email != ''

      redirect '/profile' if user.save
    end

    erb :update_profile, locals: { user: current_user }
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
