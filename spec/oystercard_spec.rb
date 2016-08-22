require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

  describe '#card' do
    it 'has a balance of zero' do
      expect(oystercard.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'responds to top-up with one argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'can increase the balance' do
      expect{oystercard.top_up 10}.to change{oystercard.balance}.by 10
    end

    it 'raises an error when more than £90 is added' do
      LIMIT = Oystercard::LIMIT
      oystercard.top_up(LIMIT)
      expect{ oystercard.top_up 1 }.to raise_error "Limit £#{LIMIT} exceeded"
    end
   end

   describe '#deduct' do
     it 'respond to deduct with one argument' do
       expect(oystercard).to respond_to(:deduct).with(1).argument
     end
     it 'can decrease the balance' do
       expect{ oystercard.deduct 10 }.to change{oystercard.balance}.by -10
     end
   end

end
