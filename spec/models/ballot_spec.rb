require 'spec_helper'

describe "Ballot Model" do
  let(:ballot) { Ballot.new }
  it 'can be created' do
    ballot.should_not be_nil
  end
end
