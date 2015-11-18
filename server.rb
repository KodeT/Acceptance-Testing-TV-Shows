require 'sinatra'
require 'csv'
require 'pry'
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")


# def tv_extractor_2
#   tv_array = []
#   CSV.foreach("television-shows.csv") do |row|
#     tv_array << TelevisionShow.new(row[0],row[1],row[2],row[4],row[3])
#   end
#   tv_array
# end

def tv_extractor
  csv_data = CSV.read 'television-shows.csv'
  headers = csv_data.shift.map {|i| i.to_sym }
  string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
  tv_hash = string_data.map {|row| Hash[*headers.zip(row).flatten] }
end

def duplicate_checker
  duplicate = false
  CSV.foreach("television-shows.csv") do |row|
    if @title == row[0]
      duplicate = true
    end
  end
  duplicate
end

get '/television_shows' do
  test_row = tv_extractor_2
  @tv_array = tv_extractor
  erb :index
end

get '/television_shows/new' do
  erb :new
end

post '/television_shows/new' do
  @valid_input = true
  @title = params[:title]
  @network = params[:network]
  @starting_year = params[:starting_year]
  @synopsis = params[:synopsis]
  @genre = params[:genre]

  if @title && @network && @starting_year && @synopsis != ""

    @duplicate = duplicate_checker

    if @duplicate == true
      erb :new
    else @duplicate == false
      CSV.open('television-shows.csv', 'a') do |file|
        file << [@title, @network, @starting_year, @synopsis, @genre]
      end
      redirect "/television_shows"
    end

  else
    @valid_input = false
    erb :new
  end

end
