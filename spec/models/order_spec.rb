require 'spec_helper'

describe Order do
  it "collects products together in preparation for a sale"
  it "calculates the total amount to be charged"
  it "makes the charge on stripe"
  it "confirms that the charge was made to the user"
end
