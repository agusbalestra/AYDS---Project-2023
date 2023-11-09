# frozen_string_literal: true

# The RecipeController class handles the routes related to the recipe book and recipe pages.
class RecipeController < Sinatra::Application
  before ['/recipe-book'] do
    redirect '/' unless session[:user_id]
    @user = User.find_by(id: session[:user_id])
  end

  # Renders the recipe book page with all the levels unlocked by the user.
  get '/recipe-book' do
    max_lv = @user.current_level
    levels = []

    if max_lv != 0
      (1..max_lv).each do |i|
        lv = Level.find(i)
        levels << lv
      end
    end

    erb :recipebook, locals: { user: @user, levels: levels }
  end

  # Renders the recipe page for a specific level.
  get '/recipe-book/:id_level' do
    lv = Level.find(params[:id_level])

    erb :recipe, locals: { level: lv, user: current_user }
  end
end
