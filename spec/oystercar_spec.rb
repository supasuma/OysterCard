require 'oyster.rb'

describe Oyster do

  it 'is initialised with a balence of 0' do
    expect(subject.balance).to eq(0)
  end

  it "is able to take new currency value" do
    expect{subject.top_up(10)}.to change{subject.balance}.by 10
  end

  it "cant hold a balance of more than 90" do
    expect{subject.top_up(91)}.to raise_error "Oyster max balance is 90.0."
  end

end
