# frozen_string_literal: true

require_relative '../models/user'

class UserController < Sinatra::Application
  # LOGIN
  post '/logmenu' do
    @user = User.find_by(name: params[:name])
    if @user.present? && @user.authenticate(params[:password_digest])
      session[:user_id] = @user.id
      redirect '/menu'
    else
      msg = 'Usuario y/o contrasena incorrectos. Intentalo nuevamente'
      erb :fail_login, locals: { msg: msg }
    end
  end

  # REGISTER
  get '/register' do
    erb :register
  end

  post '/registermenu' do
    user = User.new(params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      erb :menu, locals: { user: user }
    else
      erb :fail_register, locals: { msgfail: user.errors.full_messages }
    end
  end

  # Routes for Google authentication
  post '/auth/google_callback' do
    auth_response = request.body.read
    credential_start = auth_response.index('credential=')

    return 'Error: No authentication token found.' if credential_start.nil?

    jwt = auth_response[(credential_start + 'credential='.length)..]
    begin
      decoded_token = JWT.decode(jwt, nil, false)

      # user_id = decoded_token[0]['sub']
      name = decoded_token[0]['name']
      email = decoded_token[0]['email']

      user = User.find_by(email: email)

      unless user.present?
        user = User.new(name: name, email: email, password: SecureRandom.hex(10))
        user.auth_with_google = true # Skip certain validations

        return "Error: Unable to create a new user. #{user.errors.full_messages.join(', ')}" unless user.save
      end

      session[:user_id] = user.id
      redirect '/menu'
    rescue JWT::DecodeError
      return 'Error: Invalid token.'
    rescue StandardError => e
      return "Error: #{e.message}"
    end
  end

  # LOGOUT
  get '/logout' do
    session.clear   # Elimina todos los datos de la sesión
    redirect '/'    # Redirige al usuario a la página de inicio
  end
end
