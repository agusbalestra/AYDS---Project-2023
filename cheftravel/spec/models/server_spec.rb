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

  it 'testing menu no credentials' do
    get '/menu'
    expect(last_response.status).to eq(302)
  end

  it 'testing menu' do
    post '/logmenu', {name: "colo", password: "aguanteboca123"}
    get '/menu'
    expect(last_response.status).to eq(200)
  end

  it 'testing chile' do
    post '/logmenu', {name: "colo", password: "aguanteboca123"}
    get '/chile'
    expect(last_response.status).to eq(200)
  end

end