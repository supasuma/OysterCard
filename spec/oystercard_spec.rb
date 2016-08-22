require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

  describe '#card' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end
end
