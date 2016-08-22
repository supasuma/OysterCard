require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

  describe '#card' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'respond to top-up with one argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'increase the balance' do
      expect{oystercard.top_up 10}.to change{oystercard.balance}.by 10
    end
  end

end
