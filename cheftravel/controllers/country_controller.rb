# frozen_string_literal: true

# This class represents a controller for handling requests related to countries.
# It inherits from Sinatra::Application and defines routes for the countries of the game
# The 'before' block sets the @user instance variable to the User object corresponding to the current session.
class CountryController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  # This route renders the 'arg' view, passing the @user instance variable as a local variable.
  get '/arg' do
    erb :arg, locals: { user: @user }
  end

  # This route renders the 'chile' view, passing the @user instance variable as a local variable.
  get '/chile' do
    erb :chile, locals: { user: @user }
  end
end
