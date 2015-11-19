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
  @title = params[:title]
  @network = params[:network]
  @starting_year = params[:starting_year]
  @synopsis = params[:synopsis]
  @genre = params[:genre]
  television_show = TelevisionShow.new(@title, @network, @starting_year, @synopsis, @genre)

  if television_show.save == true
    redirect "/television_shows"
  else
    @error_type = television_show.errors
    erb :new
  end

end
