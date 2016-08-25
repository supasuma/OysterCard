require 'oystercard'

describe Oystercard do

  subject(:empty_card) { described_class.new }
  subject(:card) { described_class.new(journey_log) }
  let(:journey_log) {double :JourneyLog, get_last_fare: 1, in_journey?: true, start: nil, finish: nil}
  let(:entry) { double :station }
  let(:exit) { double :station }


  it 'Describes an account when it is first opened' do
    expect(empty_card.balance).to eq (0)
  end


  describe '#top_up' do
    it 'tops up Oystercard by amount 20' do
      expect { empty_card.top_up(20) }.to change{empty_card.balance}.by(20)
    end

    it 'raises an error when top up limit is exceeded' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT
      empty_card.top_up(maximum_limit)
      expect{ empty_card.top_up(1) }.to raise_error 'Top up limited exceeded'
    end
  end



  describe '#touch_in' do
    before(:each) do
      card.top_up(10)
    end

    it 'raises error if balance is less than minimum required' do
      msg = "Insufficient funds. Please top up."
      expect{ empty_card.touch_in(entry) }.to raise_error msg
    end

    it 'returns true when card touched in' do
      expect(card.instance_variable_get(:@journey_log)).to receive(:start).with(entry)
      card.touch_in(entry)
    end
  end

  describe '#touch_out' do

    before(:each) do
      card.top_up(10)
      card.touch_in(entry)
    end

    it 'returns true when card touched out' do
      expect(card.instance_variable_get(:@journey_log)).to receive(:finish).with(exit)
      card.touch_out(exit)
    end

    it 'charges minimum fare if card is touched in and touched out' do
    expect { card.touch_out(exit) }.to change { card.balance }.by( -Oystercard::MINIMUM_FARE)
    end

  end
  context 'charging penality fares' do
    before do
      card.top_up(50)
    end

  it 'charges penality fare if card is touched out without being touched in' do
    allow(journey_log).to receive(:in_journey?).and_return(false)
      expect { card.touch_out(exit) }.to change { card.balance }.by( -(Oystercard::PENALTY_FARE + Oystercard::MINIMUM_FARE))
  end

  it 'should charge penalty on double touch in ' do
    allow(journey_log).to receive(:in_journey?).and_return(true)
    expect { card.touch_in(entry) }.to change { card.balance }.by( -(Oystercard::PENALTY_FARE))
  end
end


end
