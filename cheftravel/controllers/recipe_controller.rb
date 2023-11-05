# frozen_string_literal: true


class RecipeController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

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

  get '/recipe-book/:id_level' do
    lv = Level.find(params[:id_level])

    erb :recipe, locals: { level: lv, user: current_user }
  end
end
