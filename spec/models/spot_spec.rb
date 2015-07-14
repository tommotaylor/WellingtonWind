require 'rails_helper'

describe Spot do
  it { should belong_to :category }
end