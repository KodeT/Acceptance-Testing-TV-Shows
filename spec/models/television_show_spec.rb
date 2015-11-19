require "spec_helper"

describe TelevisionShow do

  let(:television_show1) { TelevisionShow.new("Orange Is The New Black", "Netflix", "2014", "Woman is in jail", "Comedy") }
  let(:television_show2) { TelevisionShow.new("a", "b", "", "d", "") }
  let(:television_show3) { TelevisionShow.new("1", "2", "3", "4", "5") }
  describe '.new' do
    it 'should create a Television class' do
      expect(television_show1).to be_a(TelevisionShow)
    end
  end
  describe '#initialize' do
    it 'should have a title' do
      expect(television_show1.title).to eq("Orange Is The New Black")
    end
    it 'should have a network' do
      expect(television_show1.network).to eq("Netflix")
    end
    it 'should have a starting year' do
      expect(television_show1.starting_year).to eq("2014")
    end
    it 'should have a genre' do
      expect(television_show1.genre).to eq("Comedy")
    end
  end

  describe '#all' do
    it 'should have an array of TelevisionShow objects' do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "Friends"
        network = "NBC"
        starting_year = "1994"
        synopsis = "Six friends living in New York city"
        genre = "Comedy"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      expect(TelevisionShow.all[0].title).to eq("Friends")
    end
  end

  describe '#valid?' do
    it 'returns true if valid' do
      expect(television_show1.valid?).to eq(true)
    end

    it 'returns false if not complete' do
      expect(television_show2.valid?).to eq(false)
    end

    it 'returns false if a duplicate' do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "1"
        network = "2"
        starting_year = "3"
        synopsis = "4"
        genre = "5"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      expect(television_show3.valid?).to eq(false)
    end

    it 'returns false if it fails at everything' do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "a"
        network = "b"
        starting_year = ""
        synopsis = "d"
        genre = ""
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      expect(television_show2.valid?).to eq(false)
    end
  end

  describe '#errors' do
    it 'should return an empty array if valid' do
       television_show1.valid?
      expect(television_show1.errors).to eq([])
    end

    it 'should return an error message if incomplete' do
      television_show2.valid?
      expect(television_show2.errors).to eq(["Please fill in all required fields"])
    end

    it 'should return an error message if a duplicate' do
      CSV.open('television-shows.csv', 'a') do |file|
        title = "1"
        network = "2"
        starting_year = "3"
        synopsis = "4"
        genre = "5"
        data = [title, network, starting_year, synopsis, genre]
        file.puts(data)
      end
      television_show3.valid?
      expect(television_show3.errors).to eq(["That show has already been added"])
    end
  end

  describe '#save' do
    it 'should save the TV show if valid' do
      expect(television_show1.save).to eq(true)
    end

    it 'should not save the TV show if incomplete' do
      expect(television_show2.save).to eq(false)
    end
  end

end
