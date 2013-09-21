require 'spec_helper'

describe User do
  subject do
    User.new \
      email: 'test@example.com',
      password: 'testMe123',
      password_confirmation: 'testMe123'
  end

  it "authenticates by email and password" do
    expect(subject.email).to be_present
  end

  it "authenticates by api token" do
    expect(subject).to be_valid
    expect(subject.authentication_token).to be_present
  end
end
