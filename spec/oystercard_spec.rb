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
    let(:journey) {double(:journey, penalty_fare: nil, complete: nil, entry_station: 'entry', exit_station: 'exit')}

    before do
      oyster.top_up(10.00)
    end

    describe '#touch_in' do

      it 'should prevent touch_in if balance < 1' do
        expect {empty_oyster.touch_in(entry_station, journey)}.to raise_error "Insufficient Funds Available. Minimum Balance £#{Oystercard::MINIMUM_BALANCE}"
      end
    end

    describe '#touch_out' do

      it 'deducts £6 penalty if journey not closed' do
        allow(journey).to receive(:fare).and_return(7)
        oyster.touch_in(entry_station, journey)
        oyster.touch_in(entry_station, journey)
        expect{oyster.touch_out(exit_station, journey)}.to change{oyster.balance}.by -7.00
      end

      it 'deducts £6 penalty if journey not opened' do
        allow(journey).to receive(:fare).and_return(7)
        expect{oyster.touch_out(exit_station, journey)}.to change{oyster.balance}.by -7.00
      end

      it 'should reduce balance by £1' do
        allow(journey).to receive(:fare).and_return(1)
        oyster.touch_in(entry_station, journey)
        expect{oyster.touch_out(exit_station, journey)}.to change{oyster.balance}.by -1.00
      end

      it 'should forget journey on touch_out' do
        oyster.touch_in(entry_station, journey)
        allow(journey).to receive(:fare).and_return(1)
        oyster.touch_out(exit_station, journey)
        expect(oyster.journey).to be_nil
      end
    end
  end

  context 'recording journey history' do
    let(:entry_station) {double(:station)}
    let(:exit_station) {double(:station)}
    let(:journey) {double(:journey, penalty_fare: nil, complete: nil, entry_station: 'entry', exit_station: 'exit', fare: 1.00)}

    before do
      oyster.top_up(10.00)
    end

    describe '#view_history' do
      it 'should initialize with an empty journey history' do
        expect(oyster.view_history).to be_empty
      end

      it 'touch_out should update journey history array' do
        oyster.touch_in(entry_station, journey)
        oyster.touch_out(exit_station, journey)
        expect(oyster.view_history).to be == [{"entry" => "exit"}]
      end
    end

  end

end
