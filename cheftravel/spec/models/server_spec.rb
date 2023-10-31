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

  it 'dont exist endpoint' do
    get '/logmenu'
    expect(last_response.status).to eq(404)
  end

  it 'testing menu no credentials' do
    get '/menu'
    expect(last_response.status).to eq(302)
  end

  it 'testing login' do
    post '/logmenu', { name: 'colo', password: 'aguanteboca123' }
    expect(last_response.status).to eq(200)
  end
end
