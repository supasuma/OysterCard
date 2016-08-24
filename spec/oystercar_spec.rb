require 'oyster.rb'

describe Oyster do
  let(:station) {double :station, zone: 1}

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

  context '#touch_in' do
    it "wont run touch in unless balance is at >= minimum fare." do
      expect{subject.touch_in(station)}.to raise_error "Not enough money on card."
    end

    context 'actual journey' do

      before do
        subject.top_up(Oyster::MINIMUM_FARE)
        subject.touch_in(station)
      end

    it 'should raise penalty fare if already touched in' do
      expect{subject.touch_in(station)}.to change{subject.balance}.by -6
    end
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
    it 'should raise penalty fare if touching out without touching in' do
      expect{subject.touch_out(station)}.to change{subject.balance}.by -7
    end

  context '#journeys' do

    let(:station2) {double :station2, zone: 1}

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
