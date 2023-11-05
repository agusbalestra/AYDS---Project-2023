# frozen_string_literal: true

# This controller handles the ranking page, which displays the users ordered by their points.
class RankingController < Sinatra::Application
  before do
    @user = User.find_by(id: session[:user_id])
  end

  # Renders the ranking page with the users ordered by their points.
  get '/ranking' do
    usersname = User.select(:name, :points).order(points: :desc)
    userspoints = User.select(:points).order(points: :desc)

    erb erb :ranking, locals: { usersname: usersname, index: 0, userspoints: userspoints, user: @user }
  end
end
