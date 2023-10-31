# frozen_string_literal: true

require_relative '../models/user'

class UserController < Sinatra::Application
  post '/logmenu' do
    @user = User.find_by(name: params[:name])
    p 'llegue aca'
    p @user.present?
    p @user.authenticate(params[:password_digest])
    p '-----------------'
    if @user.present? && @user.authenticate(params[:password_digest])
      session[:user_id] = @user.id
      redirect '/menu'
    else
      msg = 'Usuario y/o contrasena incorrectos. Intentalo nuevamente'
      erb :fail_login, locals: { msg: msg }
    end
  end
end
