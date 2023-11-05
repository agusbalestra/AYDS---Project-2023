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

# The App class is a Sinatra application that serves as the main entry point for the ChefTravel web application.
# It includes the necessary controllers, middleware, and configuration for the application to function properly.
class App < Sinatra::Application
  # Controllers
  use MenuController
  use UserController
  use QuestionController
  use LevelController
  use ProfileController
  use CountryController
  use RankingController
  use RecipeController

  use OmniAuth::Builder do
    provider :google_oauth2, '832010478415-ugp0o039v71f8kv1334rckru6tegj2qa.apps.googleusercontent.com',
             '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'
  end

  enable :sessions
  register Sinatra::Cookies

  def initialize(_app = nil)
    super()
  end

  # The root page of the application.
  # Renders the index view.
  get '/' do
    erb :index
  end
end
