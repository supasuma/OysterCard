require "journey"

describe Journey do

  let(:station) { double :station}

  it 'creates a hash inside an @journey array for each journey with entry station and exit station' do
    subject.start(station)
    subject.finish(station)
    expect(subject.instance_variable_get(:@current_journey)).to include(:in => station, :out => station)
  end

describe '#fare' do
  it 'calculates a fare' do
    subject.start(station)
    subject.finish(station)
    expect(subject.fare).to eq Journey::MINIMUM_FARE
  end

  it 'charges a penalty fare for an incomplete journey' do
    subject.finish(station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  
end
end
