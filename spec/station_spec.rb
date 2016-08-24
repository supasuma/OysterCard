require 'station'

describe Station do
  subject { described_class.new(station: "Old Street", zone: 1) }

  it 'knows its name' do
    expect(subject.station).to eq("Old Street")
  end

  it  'knows its zone' do
    expect(subject.zone).to eq(1)
  end
end
