require 'oystercard'

describe Oystercard do

subject(:oyster) { described_class.new }

  describe '#balance' do

    it 'should test that a new card should have a zero balance' do
      expect(oyster.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should add argument to balance' do
      oyster.top_up(10.00)
      expect(oyster.balance).to eq 10.00
    end
  end

end
