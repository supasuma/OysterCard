require 'fare_calc'

describe FareCalculator do

subject(:fare_calculator) {described_class.new}


  it 'should calculate a fare from a journey' do
    expect(fare_calculator.calculate_fare([1,3])).to eq 3
  end

  it 'should add penalty fare if entry station nil' do
      expect(fare_calculator.calculate_fare([nil,3])).to eq 7
  end

  it 'should add penalty fare if exit station nil' do
      expect(fare_calculator.calculate_fare([1,nil])).to eq 7
  end


end
