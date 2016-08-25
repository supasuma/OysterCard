require 'oystercard'

describe Oystercard do

  subject(:empty_card) { described_class.new }
  subject(:card) { described_class.new }
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
      card.touch_in(entry)
      expect(card.instance_variable_get(:@current_journey)).not_to be_nil
    end
  end

  describe '#touch_out' do

    before(:each) do
      card.top_up(10)
      card.touch_in(entry)
    end

    it 'returns true when card touched out' do
      card.touch_out(exit)
      expect(card.instance_variable_get(:@current_journey)).to be_nil
    end

    it 'charges minimum fare if card is touched in and touched out' do
    expect { card.touch_out(exit) }.to change { card.balance }.by( -Oystercard::MINIMUM_FARE)
    end

  end
  context 'charging penality fares' do
  it 'charges penality fare if card is touched out without being touched in' do
    card.top_up(10)
      expect { card.touch_out(exit) }.to change { card.balance }.by( -(Oystercard::PENALTY_FARE + Oystercard::MINIMUM_FARE))
  end
  end

  describe '#in_journey' do
    it 'card initializes with not in journey' do
      expect(card.instance_variable_get(:@current_journey)).to be_nil
    end
  end

  describe '#journeys' do
    before(:each) do
      card.top_up(10)
    end

    let(:journey){ {entry_station: entry, exit_station: exit} }
    it 'Has an empty list of journeys by default' do
      expect(card.instance_variable_get(:@journey_history)).to be_empty
    end

    it 'records a journey' do
      card.touch_in(entry)
      card.touch_out(exit)
      expect(card.instance_variable_get(:@journey_history)).not_to be_empty
    end
  end
end
