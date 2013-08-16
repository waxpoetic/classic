require 'spec_helper'

describe Artist do
  it "will not save without a name" do
    expect(subject).to_not be_valid

    subject.name = 'the wonder bars'

    expect(subject).to be_valid
  end


  it "owns a collection of releases" do
    subject.releases.build name: 'example'

    expect(subject.releases).to_not be_empty
  end

  it "must have a cover image" do
    subject.cover_image = 'wonderbars.png'

    expect(subject.cover_image).to_not be_nil
  end
end
