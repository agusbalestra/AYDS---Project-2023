# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'sinatra/cookies'
require 'bundler/setup'
require 'sinatra/flash'

require_relative 'models/question'
require_relative 'models/user'
require_relative 'models/answer'
require_relative 'models/level'
require_relative 'models/recipe'

# Server for app
class App < Sinatra::Application
  enable :sessions
  register Sinatra::Cookies

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

  # REGISTERMENU
  get '/register' do
    erb :register
  end

  post '/registermenu' do
    user = User.new(params)
    if user.valid?
      user.set_default_points
      user.save
      session[:user_id] = user.id
      erb :menu, locals: { user: user }
    else
      erb :fail_register, locals: { msgfail: user.errors.full_messages }
    end
  end

  # LOGMENU
  post '/logmenu' do
    user = User.find_by(name: params[:name], password: params[:password])

    if user
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

      if question.present?
        if level.id == question.levels_id
          answers = Answer.where(question_id: question.id)
          user = current_user

          if level.id < 1000
            erb :question, locals: { level: level, question: question, answers: answers, user: user }
          elsif user.points > 170
            erb :frontera, locals: { level: level, question: question, answers: answers, user: user }
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
  end

  post '/question' do
    question = Question.find(params[:question_id])
    option_id = params[:option_id].to_i
    if option_id.zero? # si el usuario no seleciona una respuesta
      redirect "/level/#{question.levels_id}/question/#{question.id}"
    else # si el usuario selecciona una respuesta
      selected_option = Answer.find(option_id)
      user = current_user
      user.points_treatment(selected_option.correct, question.difficulty)
      selected_option.correct ? correct = 'correct' : correct = 'incorrect'
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

  # PROFILE
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
    user.name = new_username
    user.password = new_password
    user.email = new_email

    if new_username != '' && !User.find_by(name: new_username).nil?
      flash[:error] = 'Name is not valid.'
    elsif new_password != '' && current_pass.nil?
      flash[:error] = 'Please provide your current password.'
    elsif new_password != new_pass_confirm
      flash[:error] = 'New password and confirmation do not match.'
    elsif new_email != '' && !User.find_by(email: new_email).nil?
      flash[:error] = 'Email is not valid.'
    else
      user.update_column(:name, new_username) if new_username != ''
      user.update_column(:password, new_password) if new_password != '' && current_pass != ''
      user.update_column(:email, new_email) if new_email != ''

      redirect '/profile' if user.save
    end

    erb :update_profile, locals: { user: current_user }
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
