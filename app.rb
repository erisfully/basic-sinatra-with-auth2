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

  post "/" do

    user_array = @user_database.all.select {|user|
    user[:username] == params[:username] && user[:password] == params[:password]
    }
    if user_array != []
      erb :sign_in
    else
      erb :root
  end
  end

  get "/registration" do
    erb :registration
  end

  post "/registration" do
    @user_database.insert({username: params[:username], password: params[:password]})
    flash[:notice]= "Thanks for signing up!"
    redirect('/')
  end

end
