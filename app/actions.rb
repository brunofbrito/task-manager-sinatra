require "sinatra"
require "sinatra/activerecord"

set :database, {adapter: "sqlite3", database: "db.sqlite3"}

class Task < ActiveRecord::Base
  def timestamp
    created_at.strftime("%l:%M%P on %d/%m/%Y")
  end
end

get "/" do
  @incompleted = Task.where(status: false)
  @completed = Task.where(status: true)
  erb :index
end

get '/tasks/add' do
  erb :add
end

post "/tasks/add" do
  task = Task.new title: params[:title]
  task.save
  redirect "/"
end

get "/tasks/remove/:id" do
  Task.destroy(params[:id])
  redirect '/'
end

get "/tasks/completed/:id" do
  task = Task.find(params[:id])
  task.update(:status => true)
  # update grava logo na BD
  redirect "/"
end

get "/tasks/edit/:id" do
  @tasks = Task.find(params[:id])
  erb :edit
end

post "/tasks/edit/:id" do
   Task.update(params[:id], params.slice("title"))
  redirect '/'
end