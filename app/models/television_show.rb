require 'csv'
require 'pry'

class TelevisionShow
  GENRES = ["Action", "Mystery", "Drama", "Comedy", "Fantasy"]

  attr_reader :title, :network, :starting_year, :genre, :synopsis

  def initialize(title, network, starting_year, genre, synopsis)
    @title = title
    @network = network
    @starting_year = starting_year
    @genre = genre
    @synopsis = synopsis
  end

  def self.all
    tv_array = []
    CSV.foreach("../../television-shows.csv", headers: true) do |row|
      tv_array << TelevisionShow.new(row[0],row[1],row[2],row[4],row[3])
    end
    binding.pry
    tv_array
  end

end
