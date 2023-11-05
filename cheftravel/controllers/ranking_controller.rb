# frozen_string_literal: true

class RankingController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  get '/ranking' do
    usersname = User.select(:name, :points).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb erb :ranking, locals: { usersname: usersname, index: 0, userspoints: userspoints, user: @user }
  end
end
