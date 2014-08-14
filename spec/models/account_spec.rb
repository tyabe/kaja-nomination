require 'spec_helper'

describe "Account Model" do
  let(:account) { Account.new }
  it 'can be created' do
    expect(account).to_not be_nil
  end
end
