require 'spec_helper'

describe UserSerializer do
  fixtures :users
  let(:user) { users :tubbo }
  subject { UserSerializer.new user }

  it "exposes authentication_token as api_key" do
    expect(subject.api_key).to eq(user.authentication_token)
  end

  it "exposes email" do
    expect(subject.email).to eq(user.email)
  end

  it "exposes user id" do
    expect(subject.id).to eq(user.id)
  end
end
