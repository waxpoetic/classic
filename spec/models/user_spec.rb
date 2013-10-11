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
    expect(subject.encrypted_password).to be_present
  end
end
