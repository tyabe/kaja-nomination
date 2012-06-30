require 'spec_helper'

describe "Nominee Model" do
  let(:nominee) { Nominee.new }
  it 'can be created' do
    nominee.should_not be_nil
  end
end
