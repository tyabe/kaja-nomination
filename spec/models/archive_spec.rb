require 'spec_helper'

describe Archive do
  let(:archive) { Archive.new }
  it 'can be created' do
    expect(archive).to_not be_nil
  end
end
