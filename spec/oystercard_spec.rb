require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}

  describe 'Initializing a card' do

    it 'card has a balance of zero' do
      expect(oystercard.balance).to eq Oystercard::BALANCE
    end
    it 'is #in_journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  describe '#top_up' do

    context 'when under limit' do
    it 'responds to top-up with one argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'can increase the balance' do
      expect{oystercard.top_up 10}.to change{oystercard.balance}.by 10
    end
  end

    context 'when over limit' do
    it 'raises an error when more than £90 is added' do
      LIMIT = Oystercard::LIMIT
      oystercard.top_up(LIMIT)
      expect{ oystercard.top_up 5 }.to raise_error "Limit £#{LIMIT} exceeded"
    end
  end
  end

  context 'when travelling' do

    describe 'Checking in journey status' do
      before do
        oystercard.top_up(10) #need stub
        oystercard.touch_in
      end
      it 'In journey when touch in' do
        expect(oystercard).to be_in_journey
      end

      it 'Not in journey anymore when touch out' do
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end
    end
  end

    describe 'error messages' do
      
        it 'raises an error when balance is less than £1' do
          expect { oystercard.touch_in }.to raise_error 'not enough credit'
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
