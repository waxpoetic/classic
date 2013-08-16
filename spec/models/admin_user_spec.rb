require 'spec_helper'

describe AdminUser do
  subject { AdminUser.new \
    email: 'admin@example.com',
    password: 'swordfish',
    password_confirmation: 'swordfish'
  }

  it "authenticates with an email address" do
    subject.email = nil

    expect(subject).to_not be_valid
  end
end
