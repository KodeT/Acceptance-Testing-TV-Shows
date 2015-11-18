require "spec_helper"

describe TelevisionShow do

  let(:television_show1) { TelevisionShow.new("Orange Is The New Black", "Netflix", "2014", "Comedy", "Woman is in jail") }
  let(:television_show2) { TelevisionShow.new("a", "b", "c", "d", "c") }
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
      expect(TelevisionShow.all[1].title).to eq("a")
    end
  end
end
