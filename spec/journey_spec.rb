require "journey"

describe Journey do

  let(:station) { double :station}

  it 'not to be in journey at initialisation point' do
    expect(subject.in_journey?).to eq false
  end

  it "changes the in_journey status to true when journey starts" do
    subject.start(station)
    expect(subject).to be_in_journey
  end

  it 'isn\'t in journey anymore when touch out' do
    subject.finish(station)
    expect(subject).not_to be_in_journey
  end

  it 'stores station argument' do
    subject.start(station)
    expect(subject.instance_variable_get(:@start_station)).to eq station
  end

  it 'stores exit station when finishing the journey' do
    subject.finish(station)
    expect(subject.instance_variable_get(:@end_station)).to eq station
  end

  it 'creates empty array of all journeys' do
    expect(subject.instance_variable_get(:@journeys)).to eq []
  end

  it 'creates a hash inside an @journey array for each journey with entry station and exit station' do
    subject.start(station)
    subject.finish(station)
    expect(subject.instance_variable_get(:@journeys)[-1]).to include(:in => station, :out => station)
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
