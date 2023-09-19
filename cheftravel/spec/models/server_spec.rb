# frozen_string_literal: true

require 'rack/test'
require 'sinatra/activerecord'
require_relative '../../models/init'
require_relative '../../server'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods
  def app
    App
  end

  it 'testing index' do
    get '/'
    expect(last_response.status).to eq(200)
  end

  it 'testing register' do
    get '/register'
    expect(last_response.status).to eq(200)
  end

  context 'POST /registermenu' do
    it 'successful register' do
      user_params = { name: 'colo', password: 'aguanteboca123' }
      user = User.new(user_params)
      allow(user).to receive(:valid?).and_return(true)
      allow(user).to receive(:save).and_return(true)
      expect(User).to receive(:new).with(user_params).and_return(user)
      expect(user).to receive(:set_default_points)
      expect(user).to receive(:save)
      # POST
      post '/registermenu', user_params
    end

    it 'failed register' do
      # incorrect params
      post '/registermenu', { name: 'a', password: 'a' }
      expect(last_response.body).to include('user.errors.fullmesages')
    end
  end

  it 'dont exist endpoint' do
    get '/logmenu'
    expect(last_response.status).to eq(404)
  end

  it 'testing menu no credentials' do
    get '/menu'
    expect(last_response.status).to eq(302)
  end

  it 'successful login' do
    post '/logmenu', { name: 'colo', password: 'aguanteboca123' }
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.path).to eq('/menu')
  end

  it 'failed login' do
    post '/logmenu', { name: 'a', password: 'a' }
    expect(last_response).to be_ok
    expect(last_response.body).to include('Usuario y/o contraseña incorrectos. Inténtalo nuevamente')
  end
end
