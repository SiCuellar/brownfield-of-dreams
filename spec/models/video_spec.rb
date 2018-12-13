require 'rails_helper'

RSpec.describe Video, type: :model do
  it {should validate_numericality_of(:position)}
end
