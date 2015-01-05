require 'rubygems'
require 'sinatra'
require 'pry'

set :sessions, true

get '/' do
  erb :home
end

get '/user' do
  erb :user
end

get '/game' do
  erb :game
end

post '/game' do
  session[:username] = params[:username]
  erb :game
end
