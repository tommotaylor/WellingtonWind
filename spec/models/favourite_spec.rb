require 'rails_helper'

describe Favourite do

  it { should belong_to(:user) }
  it { should belong_to(:spot) }
  it { should validate_numericality_of(:list_order) }

end