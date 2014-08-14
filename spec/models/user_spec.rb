require 'spec_helper'

describe "User Model" do
  let(:user) { User.new }
  it 'can be created' do
    expect(user).to_not be_nil
  end
end
