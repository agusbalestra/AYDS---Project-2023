# frozen_string_literal: true

require 'open-uri'

# The MenuController class handles the routes related to the menu of the ChefTravel web application.
class MenuController < Sinatra::Application
  before ['/menu'] do
    redirect '/' unless session[:user_id]
    @user = User.find_by(id: session[:user_id])
  end

  # Renders the menu page with the user's information.
  get '/menu' do
    ip = public_ip
    country = public_ip_country(ip)
    p country
    erb :menu, locals: { user: @user, ip: ip, country: country }
  end

  def public_ip
    response = open('http://api.ipify.org?format=json').read
    json = JSON.parse(response)
    json['ip']
  end

  def public_ip_country(ip)
    response = open("http://ip-api.com/json/#{ip}").read
    json = JSON.parse(response)
    json['country']
  end
end
