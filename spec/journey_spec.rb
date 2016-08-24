require "journey"

describe Journey do

  it 'not to be in journey at initialisation point' do
    expect(subject.in_journey?).to eq false
  end

  it "changes the in_journey status to true when journey starts" do
    subject.start
    expect(subject).to be_in_journey
  end
end
