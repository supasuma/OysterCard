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

    it 'raises error if balance is less than minimum required' do
      msg = "Insufficient funds. Please top up."
      expect{ empty_card.touch_in(entry) }.to raise_error msg
    end

    it 'returns true when card touched in' do
      card.touch_in(entry)
      expect(card).to be_in_journey
    end

    it 'record entry station upon touch in' do
      card.touch_in(entry)
      expect(card.entry_station).to eq entry
    end
  end

  describe '#touch_out' do


    it 'returns true when card touched out' do
      expect(card).to_not be_in_journey
    end

    it 'deducts fare when touching out' do
      expect { card.touch_out(exit)}.to change { card.balance }.by( -Oystercard::MINIMUM_FARE)
    end

    it 'forgets entry_station on touch out' do
      expect(card.entry_station).to eq nil
    end

    it 'charges penality fare if card is touched out without being touched in' do
    expect { card.touch_out }.to change { card.blance }.by( -Oystercard::PENALTY_FARE)
    end

    it 'charges minimum fare if card is touched in and touched out' do
    card.touch_in
    expect { card.touch_out }.to change { card.blance }.by( -Oystercard::MINIMUM_FARE)
    end
  end

  describe '#in_journey' do
    it 'card initializes with not in journey' do
      expect(card.in_journey?).to be false
    end
  end

  describe '#journeys' do
    let(:journey){ {entry_station: entry, exit_station: exit} }
    it 'Has an empty list of journeys by default' do
      expect(card.journeys).to be_empty
    end

    it 'records a journey' do
      card.touch_in(entry)
      card.touch_out(exit)
      expect(card.journeys).to include journey
    end
  end
end
