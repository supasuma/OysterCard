require 'journey_log'

describe JourneyLog do

subject(:journey_log) {described_class.new(journey_class)}
let (:journey_class) { double(:journey_class, new: journey) }
let (:journey) { double(:journey, start: nil, finish: nil, fare: 1) }

let(:station) { double(:station) }

  context 'initialization' do
    it 'saves a journey_class' do
      expect(journey_log.instance_variable_get(:@journey_class)).to eq(journey_class)
    end
  end

  describe '#start' do
    before do
      journey_log.start(station)
    end
    it 'should create a new journey' do
      expect(journey_log.instance_variable_get(:@current_journey)).to eq(journey)
    end
    it 'should start a new journey' do
      expect(journey).to have_received(:start).with(station)
    end
  end

  describe '#finish' do
    before do
      journey_log.start(station)
      journey_log.finish(station)
    end
    it 'should finish the current journey' do
      expect(journey).to have_received(:finish).with(station)
    end
    it 'should record the current journey' do
      expect(journey_log.instance_variable_get(:@history)).to eq [journey]
    end
    it 'should reset the current journey' do
      expect(journey_log.instance_variable_get(:@current_journey)).to be_nil
    end
  end

  describe '#get_outstanding_charges' do
    context 'normal touch_in / touch_out' do
      it 'should charge minimum fare' do
        journey_log.start(station)
        journey_log.finish(station)
        expect(journey_log.get_outstanding_charges).to eq(1)
      end
      it 'should reset outstanding_charges' do
        journey_log.start(station)
        journey_log.finish(station)
        journey_log.get_outstanding_charges
        expect(journey_log.get_outstanding_charges).to eq(0)
      end
    end

    context 'charging penalty fares' do
      context 'should add penalty fare on touch out with no touch in' do
        it 'should start journey' do
          journey_log.finish(station)
          expect(journey).to have_received(:start).with(nil)
        end
        it 'should add penalty fare' do
          journey_log.finish(station)
          expect(journey_log.get_outstanding_charges).to eq(7)
        end
      end
      context 'should add penalty fare on touch in without previous touch out' do
        before do
          journey_log.start(station)
          journey_log.start(station)
        end
        it 'should finish journey' do
          expect(journey).to have_received(:finish).with(nil)
        end
        it 'should add penalty fare' do
          expect(journey_log.get_outstanding_charges).to eq(7)
        end
        it 'records incomplete journey' do
          expect(journey_log.instance_variable_get(:@history)).to eq [journey]
        end
        it 'resets current_journey' do
          expect(journey_log.instance_variable_get(:@current_journey)).to eq journey
        end
      end
    end
  end

end
