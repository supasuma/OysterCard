require 'oyster.rb'

describe Oyster do
  let(:station) {double :station}

  context 'initialize' do
    it 'is initialised with a balence of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  context '#top_up' do
    it "cant hold a balance of more than 90" do
      expect{subject.top_up(91)}.to raise_error "Oyster max balance is 90.0."
    end

    it "is able to take new currency value" do
      expect{subject.top_up(10)}.to change{subject.balance}.by 10
    end
  end

  context '#deduct' do
    it 'will deduct the balance by a given amount' do
      expect{subject.deduct(10)}.to change{subject.balance}.by -10
    end
  end

  context '#in_journey?' do
    it 'starts out as not being on a journey' do
      expect(subject.in_journey?).to eq(false)
    end

    it 'changes to being on a journey when you touch in' do
      subject.top_up(Oyster::MINIMUM_FARE) #Will raise error without first adding balance.
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end
  end

  context '#touch_in' do
    it 'is possible to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it "wont run touch in unless balance is at >= minimum fare." do
      expect{subject.touch_in(station)}.to raise_error "Not enough money on card."
    end

    it 'changes the station var to the touch in station' do
      subject.top_up(Oyster::MINIMUM_FARE) #Will raise error without first adding balance.
      expect(subject.touch_in(station)).to eq(subject.entry_station)
    end
  end

  context '#touch_out' do
    before(:each) do
      subject.top_up(Oyster::MINIMUM_FARE) #Will raise error without first adding balance.
      subject.touch_in(station)
    end

    it 'is possible to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it "deducts fair on touch out" do
      expect{subject.touch_out(station)}.to change{subject.balance}.by -Oyster::MINIMUM_FARE
    end
  end

  context '#journeys' do

    let(:station2) {double :station2}

    it "returns an empty list of journeys on ititialization" do
      expect(subject.journeys).to eq([])
    end

    it "creates a entry and exit hash within journey" do
      subject.top_up(Oyster::MINIMUM_FARE) #Will raise error without first adding balance.
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.journeys).to include({:entry => station, :exit => station2})
    end
  end
end
