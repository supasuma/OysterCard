require 'oyster.rb'

describe Oyster do
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
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end
  end

  context '#touch_in' do
    it 'is possible to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end
  end

  context '#touch_out' do
    it 'is possible to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
  end
end
