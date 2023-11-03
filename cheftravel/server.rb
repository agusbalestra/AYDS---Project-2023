# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'sinatra/flash'
require 'sinatra/reloader'
require 'bundler/setup'
require 'bcrypt'
require 'omniauth'
require 'omniauth-google-oauth2'
require 'json'
require 'jwt'

require_relative 'models/init'
require_relative 'controllers/init'

# Server for app
class App < Sinatra::Application
  # Controllers
  use UserController
  use QuestionController
  use LevelController
  use ProfileController
  use CountryController

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
    @user = current_user
  end

  # root page
  get '/' do
    erb :index
  end

  get '/menu' do
    erb :menu, locals: { user: @user }
  end

  get '/ranking' do
    usersname = User.select(:name, :points).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb erb :ranking, locals: { usersname: usersname, index: 0, userspoints: userspoints, user: @user }
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
