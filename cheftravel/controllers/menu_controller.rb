# frozen_string_literal: true

class MenuController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  get '/menu' do
    erb :menu, locals: { user: @user }
  end
end
