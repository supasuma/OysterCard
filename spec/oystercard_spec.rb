require 'oystercard'

describe Oystercard do
    subject(:oystercard) {described_class.new}
    let(:amount) { double :amount }
    let(:station) { double :station }
    let(:station2) { double :station2 }

  describe 'Initializing a card' do

    it 'card has a balance of zero' do
      expect(oystercard.instance_variable_get(:@balance)).to eq Oystercard::BALANCE
    end
  end

  describe '#top_up' do

    context 'when under limit' do
      it 'responds to top-up with one argument' do
        expect(oystercard).to respond_to(:top_up).with(1).argument
      end

      it 'can increase the balance' do
        expect{oystercard.top_up 10}.to change{oystercard.instance_variable_get(:@balance)}.by 10
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

    describe 'Checking impact touch in and out' do
      before do
        oystercard.top_up(10)
        oystercard.touch_in(station)
      end

      # it 'check a charge is made when touch out' do
      #   expect {oystercard.touch_out(station)}.to change{oystercard.instance_variable_get(:@balance)}.by(-2)
      # end
    end

  describe 'error messages' do
    it 'raises an error when balance is less than minimum balance' do
      expect { oystercard.touch_in(station) }.to raise_error 'below minimum balance'
    end
  end

  describe 'interaction with Journey class' do
    let(:journey_class) {double :journey_class, new: journey}
    let(:journey) {double :journey, start: nil}

    it 'creates a new journey on touch in' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(journey).to have_received(:start)
    end
  end

end
