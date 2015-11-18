require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")

def tv_extractor
  csv_data = CSV.read 'television-shows.csv'
  headers = csv_data.shift.map {|i| i.to_sym }
  string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
  tv_hash = string_data.map {|row| Hash[*headers.zip(row).flatten] }
end

get '/television_shows' do
  @tv_array = tv_extractor
  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_shows/new' do
  @status = false
  @title = params[:title]
  @network = params[:network]
  @starting_year = params[:starting_year]
  @synopsis = params[:synopsis]
  @genre = params[:genre]
  if @title && @network && @starting_year && @synopsis != ""
    CSV.open('television-shows.csv', 'a') do |file|
      file << [@title, @network, @starting_year, @synopsis, @genre]
    end
    redirect "/television_shows"
  else
    @status = true
    erb :new
  end

end
