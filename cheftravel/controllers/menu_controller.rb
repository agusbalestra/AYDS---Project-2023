# frozen_string_literal: true

# The MenuController class handles the routes related to the menu of the ChefTravel web application.
class MenuController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  # Renders the menu page with the user's information.
  get '/menu' do
    erb :menu, locals: { user: @user }
  end
end
