require 'csv'
require 'pry'

class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  attr_reader :title, :network, :starting_year, :genre, :synopsis

  def initialize(title, network, starting_year, synopsis, genre)
    @title = title
    @network = network
    @starting_year = starting_year
    @genre = genre
    @synopsis = synopsis
    @validity_status = ""
  end

  def self.all
    tv_array = []
    CSV.foreach("television-shows.csv", headers: true) do |row|
      tv_array << TelevisionShow.new(row[0],row[1],row[2],row[3],row[4])
    end
    tv_array
  end

  def errors
    if @validity_status == true
      return []
    elsif @validity_status == 1
      return ["Please fill in all required fields"]
    elsif @validity_status == 2
      return ["That show has already been added"]
    elsif @validity_status == 3
      return ["Please fill in all required fields", "The show has already been added"]
    end
  end

  def is_complete?
    if (@title != "") && (@network != "") && (@starting_year != "") && (@genre != "") && (@synopsis != nil)
      return true
    else
      return false
    end
  end

  def valid?
    duplicate = false
    CSV.foreach("television-shows.csv") do |row|
      if @title == row[0]
        duplicate = true
      end
    end
    if is_complete? == true && duplicate == false
      return @validity_status = true
    elsif is_complete? == false && duplicate == true
      @validity_status = 3
      return false
    elsif is_complete? == false
      @validity_status = 1
      return false
    elsif duplicate == true
      @validity_status = 2
      return false
    end
  end

  def save
    if valid? == true
      CSV.open('television-shows.csv', 'a') do |file|
        title = @title
        network = @network
        starting_year = @starting_year
        synopsis = @synopsis
        genre = @genre
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      return true
    else valid? == false
      return false
    end
  end

end
