require 'rails_helper'

describe User do
  it { should have_many(:favourites).order(:list_order) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
end