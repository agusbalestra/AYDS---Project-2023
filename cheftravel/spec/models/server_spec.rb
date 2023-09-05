require 'rack/test'
require 'sinatra/activerecord'
require_relative '../../models/init.rb'
require_relative '../../server.rb'


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

  it 'testing arg' do
    post '/logmenu', {name: "carlitos", password: "boquita"}
    get '/arg'
    expect(last_response.status).to eq(200)
  end

  it 'testing chile' do
    post '/logmenu', {name: "romanino", password: "avostegusta?"}
    get '/chile'
    expect(last_response.status).to eq(200)
  end

end