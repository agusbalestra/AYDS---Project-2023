# frozen_string_literal: true

class RecipeController < Sinatra::Application
  get '/recipe-book' do
    max_lv = current_user.current_level
    levels = []

    if max_lv != 0
      (1..max_lv).each do |i|
        lv = Level.find(i)
        levels << lv
      end
    end

    erb :recipebook, locals: { user: current_user, levels: levels }
  end

  get '/recipe-book/:id_level' do
    lv = Level.find(params[:id_level])

    erb :recipe, locals: { level: lv, user: current_user }
  end
end
