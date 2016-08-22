require 'oystercard'

describe Oystercard do

subject(:oyster) { described_class.new }

  describe '#balance' do

    it 'should test that a new card should have a zero balance' do
      expect(oyster.balance).to eq 0.00
    end
  end


  context 'adjusting balances on oystercard' do

  before do
    oyster.top_up(10.00)
  end

    describe '#top_up' do
      it 'should add argument to balance' do
        expect(oyster.balance).to eq 10.00
      end

      it 'should raise error if resultant balance is over 90' do
        msg = "Top up would exceed limit £#{Oystercard::BALANCE_LIMIT}"
        expect{oyster.top_up(100.00)}.to raise_error msg
      end
    end

  end

  context 'changing journey states' do

    subject(:empty_oyster) { described_class.new }
    let(:station) {double(:station)}
    before do
      oyster.top_up(10.00)
    end

    describe '#in_journey?' do
      it 'should return false when initialized' do
        expect(oyster).not_to be_in_journey
      end
    end

    describe '#touch_in' do
      let(:station) {double(:station)}
      it 'should update in_journey? to true' do
        oyster.touch_in(station)
        expect(oyster).to be_in_journey
      end
      it 'should prevent touch_in if balance < 1' do
        expect {empty_oyster.touch_in(station)}.to raise_error "Insufficient Funds Available. Minimum Balance £#{Oystercard::MINIMUM_BALANCE}"
      end
      it 'should remember entry_station' do
        oyster.touch_in(station)
        expect(oyster.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      it 'should update in_journey? to false' do
        oyster.touch_in(station)
        oyster.touch_out
        expect(oyster).not_to be_in_journey
      end
      it 'should reduce balance by £1' do
        expect{oyster.touch_out}.to change{oyster.balance}.by -1.00
      end
      it 'should forget entry_station on touch_out' do
        oyster.touch_in(station)
        oyster.touch_out
        expect(oyster.entry_station).to be_nil
      end
    end
  end

end
