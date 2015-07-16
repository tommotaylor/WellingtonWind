require 'rails_helper'

describe User do
  it { should have_many(:favourites).order(:list_order) }
end