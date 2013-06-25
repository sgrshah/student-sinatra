require 'sinatra/base'
require './student.rb'


# Why is it a good idea to wrap our App class in a module?
module StudentSite
  
  class App < Sinatra::Base
   
    get '/hello-world' do
      @random_numbers = (1..20).to_a
      erb :hello
    end
     
    get '/artists' do
      @artists = ["Led Zeppelin", "New Order", "Another Band"]
      erb :artists
    end
     
    get '/students' do
      @id = params[:id]
      @students = Student.all
      erb :'students/studs'
    end


    get '/students/:id' do |id|
      @student = Student.find(id)
      erb :'students/profile'
    end

  end
end