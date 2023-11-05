# frozen_string_literal: true

require_relative '../models/init'

# The ProfileController class handles the routes related to the user profile.
class ProfileController < Sinatra::Application
  before ['/profile', '/update_profile'] do
    redirect '/' unless session[:user_id]
    @user = User.find_by(id: session[:user_id])
  end

  # Renders the user profile page with the user's progress.
  get '/profile' do
    total_questions = Question.count
    answered_questions = CorrectQuestions.where(user_id: @user.id).count
    progress = (answered_questions.to_f / total_questions * 100).round(2)

    erb :profile, locals: { user: @user, progress: progress }
  end

  # Renders the update profile page with the user's information.
  get '/update_profile' do
    erb :update_profile, locals: { user: @user, errors: [] }
  end

  # Updates the user's information and redirects to the user profile page.
  post '/update_profile' do
    new_username = params[:name]
    current_pass = params[:current_password]
    new_password = params[:password]
    new_pass_confirm = params[:password_confirmation]
    new_email = params[:email]

    if new_username != '' && User.find_by(name: new_username)
      flash[:error] = 'Name is not valid.'
    elsif new_password != '' && current_pass.nil?
      flash[:error] = 'Please provide your current password.'
    elsif new_password != new_pass_confirm
      flash[:error] = 'New password and confirmation do not match.'
    elsif new_email != '' && User.find_by(email: new_email)
      flash[:error] = 'Email is not valid.'
    else
      @user.name = new_username if new_username != ''
      @user.password_digest = new_password if new_password != '' && current_pass != ''
      @user.email = new_email if new_email != ''

      redirect '/profile' if @user.save
    end

    erb :update_profile, locals: { user: @user }
  end
end
