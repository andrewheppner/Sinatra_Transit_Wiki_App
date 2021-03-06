require 'rubygems'
require 'bundler/setup'
require 'bcrypt'
require 'uri'

require 'active_support/all'

# Load Sinatra Framework (with AR)
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib/all' # Requires cookies, among other things

require 'byebug'
require 'flickraw'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SECRET_KEY'] || 'asfdhgjdhtrgdfgdhgfhfgv'
  set :domain_name, ENV['DOMAIN_NAME'] || 'http://localhost:3000'

  set :views, File.join(Sinatra::Application.root, "app", "views")
end

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')

FlickRaw.api_key="1be309fa475fa710a58e3eb0ae19ccd3"
FlickRaw.shared_secret="b9de7347976629c9"