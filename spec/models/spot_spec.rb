require 'rails_helper'

describe Spot do
  it { should have_and_belong_to_many(:categories) }
end