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
    #let(:Journey) {double :Journey, new: journey}
    let(:Journey) {double :Journey }
    let(:journey) {double :journey, start: nil, finish: nil}

    it 'creates a new journey on touch in' do
      allow(Journey).to receive(:new) {journey}
      subject.top_up(20)
      subject.touch_in(station)
      expect(journey).to have_received(:start)
    end

    it 'sends a finish message to journey class' do
      subject.top_up(20)
      subject.touch_out(station)
      expect(journey).to have_received(:finish)
    end
  end

end
