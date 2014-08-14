require 'spec_helper'

describe "Ballot Model" do
  let(:ballot) { Ballot.new }
  it 'can be created' do
    expect(ballot).to_not be_nil
  end
end
