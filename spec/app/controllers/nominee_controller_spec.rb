require 'spec_helper'

describe "NomineeController" do
  it { get '/';   expect(last_response).to be_ok }
end
