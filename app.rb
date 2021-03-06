require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'
require './image_uploader.rb'

get '/' do
    @contents = Contribution.order('id desc').all
    erb :index
end

post '/new' do
    Contribution.create({
        name: params[:user_name],
        body: params[:body],
        img: ""
    })
    
    if params[:file]
        image_upload(params[:file])
    end
    
    redirect '/'
end