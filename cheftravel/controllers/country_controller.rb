# frozen_string_literal: true

class CountryController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  get '/arg' do
    erb :arg, locals: { user: @user }
  end

  get '/chile' do
    erb :chile, locals: { user: @user }
  end
end
