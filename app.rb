require "sinatra"
require "rack-flash"

require "./lib/user_database"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @user_database = UserDatabase.new
  end

  get "/" do
      erb :root
  end

  get "/registration" do
    erb :registration
  end

  post "/registration" do
    @user_database.insert({username: params[:username], password: params[:password]})
    flash[:notice]= "Thanks for signing up!"
    redirect('/')
  end

  post "/" do
    erb :sign_in
  end

end
