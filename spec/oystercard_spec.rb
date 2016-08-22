require 'oystercard'

describe Oystercard do

subject(:oyster) { described_class.new }

  describe '#balance' do

    it 'should test that a new card should have a zero balance' do
      expect(oyster.balance).to eq 0
    end

  end

end
