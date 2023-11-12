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
