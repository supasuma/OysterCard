require 'station'

describe Station do

  it 'exposes station variable' do
    expect(subject).to respond_to(:station)
  end

  it 'exposes zone variable' do
    expect(subject).to respond_to(:zone)
  end
end
