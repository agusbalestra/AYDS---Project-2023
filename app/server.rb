require "sinatra"

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  get '/' do
    "Bienvenido a ChefTravel"
  end
end