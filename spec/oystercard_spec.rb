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
    let(:entry_station) {double(:station)}
    let(:exit_station) {double(:station)}

    before do
      oyster.top_up(10.00)
    end

    describe '#touch_in' do

      it 'should prevent touch_in if balance < 1' do
        expect {empty_oyster.touch_in(entry_station)}.to raise_error "Insufficient Funds Available. Minimum Balance £#{Oystercard::MINIMUM_BALANCE}"
      end
    end

    describe '#touch_out' do

      it 'deducts £6 penalty if journey not closed' do
        oyster.touch_in(entry_station)
        oyster.touch_in(entry_station)
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by -7.00
      end

      it 'deducts £6 penalty if journey not opened' do
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by -7.00
      end

      it 'should reduce balance by £1' do
        oyster.touch_in(entry_station)
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by -1.00
      end

      it 'should forget entry_station on touch_out' do
        oyster.touch_in(entry_station)
        oyster.touch_out(exit_station)
        expect(oyster.journey).to be_nil
      end
    end
  end

  context 'recording journey history' do
    let(:entry_station) {double(:station)}
    let(:exit_station) {double(:station)}

    before do
      oyster.top_up(10.00)
    end

    describe '#view_history' do
      it 'should initialize with an empty journey history' do
        expect(oyster.view_history).to be_empty
      end

      it 'touch_out should update journey history array' do
        oyster.touch_in(entry_station)
        oyster.touch_out(exit_station)
        expect(oyster.view_history).to be == [{entry_station => exit_station}]
      end

    end

  end

end
