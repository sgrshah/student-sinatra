require 'sinatra/base'
require './student.rb'


# Why is it a good idea to wrap our App class in a module?
module StudentSite
  
  class App < Sinatra::Base
     
    get '/students' do
      @id = params[:id]
      @students = Student.all
      erb :'students/studs'
    end

    get '/' do 
      redirect to "/students"
    end

    get '/students/new' do
      erb :form
    end

    post '/students/new-user' do
      @student = Student.new
      @student.name = params[:name]
      @student.image_url = params[:image_url]
      @student.quote = params[:quote]
      @student.twitter_url = params[:twitter_url]
      @student.linkedin_url = params[:linkedin_url]
      @student.github_url = params[:github_url]
      @student.blog_url = params[:blog_url]
      @student.treehouse_url = params[:treehouse_url]
      @student.codeschool_url = params[:codeschool_url]
      @student.coderwall_url = params[:coderwall_url]
      @student.save

      erb :'students/profile'
    end

    post '/students/:id/edited-user' do 
      @id = params[:id]
      @student = Student.find(params[:id])
      @student.name = params[:name]
      @student.image_url = params[:image_url]
      @student.quote = params[:quote]
      @student.twitter_url = params[:twitter_url]
      @student.linkedin_url = params[:linkedin_url]
      @student.github_url = params[:github_url]
      @student.blog_url = params[:blog_url]
      @student.treehouse_url = params[:treehouse_url]
      @student.codeschool_url = params[:codeschool_url]
      @student.coderwall_url = params[:coderwall_url]
      @student.save

      erb :'students/profile'
    end

    get '/students/:id' do |id|
      @id = params[:id]
      @student = Student.find(id)

      erb :'students/profile'
    end

    get '/students/:id/edit' do |id|
      @student = Student.find(params[:id])
      @id = params[:id]
      erb :edit
    end

  end
end
