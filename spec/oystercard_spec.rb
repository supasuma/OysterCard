require 'oystercard'

describe Oystercard do
      let(:journey_log) {double :journey_log, start: nil, finish: nil, get_outstanding_charges: 1}
      subject(:oystercard) {described_class.new(journey_log: journey_log)}

      let(:station) { double :station }
      let(:station2) { double :station2 }

  describe '#top_up' do
    context 'when over limit' do
      it 'raises an error when more than £90 is added' do
        LIMIT = Oystercard::LIMIT
        oystercard.top_up(LIMIT)
        expect{ oystercard.top_up 5 }.to raise_error "Limit £#{LIMIT} exceeded"
      end
    end

    context 'when balance within limit' do
      it 'adds amount to balance' do
        oystercard.top_up(10)
        expect(oystercard.instance_variable_get(:@balance)).to eq 10
      end
    end
  end

  describe '#touch_in' do
    context 'when previously touched out' do
      it 'raises an error when balance is less than minimum balance' do
        expect { oystercard.touch_in(station) }.to raise_error 'below minimum balance'
      end

      it 'sends entry_station to journey' do
        oystercard.top_up(10)
        oystercard.touch_in(station)
        expect(journey_log).to have_received(:start).with(station)
      end
    end

  end

  describe '#touch_out' do
    context 'when touched in' do
      before do
        oystercard.top_up(10)
        oystercard.touch_in(station)
        oystercard.touch_out(station)
      end
      it 'sends exit_station to journey' do
        expect(journey_log).to have_received(:finish).with(station)
      end

      it 'charges the minimum fare' do
        expect(oystercard.instance_variable_get(:@balance)).to eq 9
      end
    end
  end
end
