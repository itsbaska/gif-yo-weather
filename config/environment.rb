# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'bcrypt'

require 'erb'
require 'giphy'

require 'net/http'
require 'json'

require 'weather-api'


begin
  require 'dotenv'
  Dotenv.load
  rescue LoadError
end


# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

Giphy::Configuration.configure do |config|
  config.version = 'giphy', '~> 3.0'
  config.api_key = ENV["GIF_SECRET"]
end

# Set up the controllers and helpers and services OH MY!
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'services', '*.rb')].each { |file| require file }


# Include ApplicationRecord. This ports over the semantics seen in Rails 5 and
# accustoms students to inheriting from ApplicationRecord.
require APP_ROOT.join('app', 'models', 'application_record').to_s

# Set up the database
require APP_ROOT.join('config', 'database')
